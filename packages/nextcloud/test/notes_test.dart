import 'package:nextcloud/core.dart';
import 'package:nextcloud/notes.dart';
import 'package:test/test.dart';

import 'helper.dart';

void main() {
  group(
    'notes',
    () {
      late DockerImage image;
      setUpAll(() async => image = await getDockerImage());

      late DockerContainer container;
      late TestNextcloudClient client;
      setUp(() async {
        container = await getDockerContainer(image);
        client = await getTestClient(container);
      });
      tearDown(() => container.destroy());

      test('Is supported', () async {
        final response = await client.core.ocs.getCapabilities();
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        final (supported, _) = client.notes.isSupported(response.body.ocs.data);
        expect(supported, isTrue);
      });

      test('Create note favorite', () async {
        final response = await client.notes.createNote(
          title: 'a',
          content: 'b',
          category: 'c',
          favorite: 1,
        );
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        expect(response.body.id, isPositive);
        expect(response.body.title, 'a');
        expect(response.body.content, 'b');
        expect(response.body.category, 'c');
        expect(response.body.favorite, true);
        expect(response.body.readonly, false);
        expect(response.body.etag, isNotNull);
        expect(response.body.modified, isNotNull);
      });

      test('Create note not favorite', () async {
        final response = await client.notes.createNote(
          title: 'a',
          content: 'b',
          category: 'c',
        );
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        expect(response.body.id, isPositive);
        expect(response.body.title, 'a');
        expect(response.body.content, 'b');
        expect(response.body.category, 'c');
        expect(response.body.favorite, false);
        expect(response.body.readonly, false);
        expect(response.body.etag, isNotNull);
        expect(response.body.modified, isNotNull);
      });

      test('Get notes', () async {
        await client.notes.createNote(title: 'a');
        await client.notes.createNote(title: 'b');

        final response = await client.notes.getNotes();
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        expect(response.body, hasLength(2));
        expect(response.body[0].title, 'a');
        expect(response.body[1].title, 'b');
      });

      test('Get note', () async {
        final response = await client.notes.getNote(
          id: (await client.notes.createNote(title: 'a')).body.id,
        );
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        expect(response.body.title, 'a');
      });

      test('Update note', () async {
        final id = (await client.notes.createNote(title: 'a')).body.id;
        await client.notes.updateNote(
          id: id,
          title: 'b',
        );

        final response = await client.notes.getNote(id: id);
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        expect(response.body.title, 'b');
      });

      test('Update note fail changed on server', () async {
        final response = await client.notes.createNote(title: 'a');
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        await client.notes.updateNote(
          id: response.body.id,
          title: 'b',
          ifMatch: '"${response.body.etag}"',
        );
        expect(
          () => client.notes.updateNote(
            id: response.body.id,
            title: 'c',
            ifMatch: '"${response.body.etag}"',
          ),
          throwsA(predicate((final e) => (e! as DynamiteApiException).statusCode == 412)),
        );
      });

      test('Delete note', () async {
        final id = (await client.notes.createNote(title: 'a')).body.id;

        var response = await client.notes.getNotes();
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        expect(response.body, hasLength(1));

        await client.notes.deleteNote(id: id);

        response = await client.notes.getNotes();
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        expect(response.body, hasLength(0));
      });

      test('Get settings', () async {
        final response = await client.notes.getSettings();
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        expect(response.body.notesPath, 'Notes');
        expect(response.body.fileSuffix, '.md');
        expect(response.body.noteMode, NotesSettings_NoteMode.rich);
      });

      test('Update settings', () async {
        var response = await client.notes.updateSettings(
          settings: NotesSettings(
            (final b) => b
              ..notesPath = 'Test Notes'
              ..fileSuffix = '.txt'
              ..noteMode = NotesSettings_NoteMode.preview,
          ),
        );
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        expect(response.body.notesPath, 'Test Notes');
        expect(response.body.fileSuffix, '.txt');
        expect(response.body.noteMode, NotesSettings_NoteMode.preview);

        response = await client.notes.getSettings();
        expect(response.statusCode, 200);
        expect(() => response.headers, isA<void>());

        expect(response.body.notesPath, 'Test Notes');
        expect(response.body.fileSuffix, '.txt');
        expect(response.body.noteMode, NotesSettings_NoteMode.preview);
      });
    },
    retry: retryCount,
    timeout: timeout,
  );
}
