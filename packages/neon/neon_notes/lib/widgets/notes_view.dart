part of '../neon_notes.dart';

class NotesView extends StatelessWidget {
  const NotesView({
    required this.bloc,
    this.category,
    super.key,
  });

  final NotesBloc bloc;
  final String? category;

  @override
  Widget build(final BuildContext context) => ResultBuilder<List<NotesNote>>.behaviorSubject(
        stream: bloc.notes,
        builder: (final context, final notes) => SortBoxBuilder<NotesSortProperty, NotesNote>(
          sortBox: notesSortBox,
          presort: const {
            (NotesSortProperty.favorite, SortBoxOrder.ascending),
          },
          sortProperty: bloc.options.notesSortPropertyOption,
          sortBoxOrder: bloc.options.notesSortBoxOrderOption,
          input: category != null ? notes.data?.where((final note) => note.category == category).toList() : notes.data,
          builder: (final context, final sorted) => NeonListView(
            scrollKey: 'notes-notes',
            isLoading: notes.isLoading,
            error: notes.error,
            onRefresh: bloc.refresh,
            itemCount: sorted.length,
            itemBuilder: (final context, final index) => _buildNote(context, sorted[index]),
          ),
        ),
      );

  Widget _buildNote(
    final BuildContext context,
    final NotesNote note,
  ) =>
      ListTile(
        title: Text(note.title),
        subtitle: Row(
          children: [
            RelativeTime(
              date: DateTime.fromMillisecondsSinceEpoch(note.modified * 1000),
            ),
            if (note.category.isNotEmpty) ...[
              const SizedBox(
                width: 8,
              ),
              Icon(
                MdiIcons.tag,
                size: smallIconSize,
                color: NotesCategoryColor.compute(note.category),
              ),
              const SizedBox(
                width: 2,
              ),
              Text(note.category),
            ],
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            bloc.updateNote(
              note.id,
              note.etag,
              favorite: !note.favorite,
            );
          },
          tooltip: note.favorite ? AppLocalizations.of(context).noteUnstar : AppLocalizations.of(context).noteStar,
          icon: Icon(
            note.favorite ? Icons.star : Icons.star_outline,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (final context) => NotesNotePage(
                bloc: NotesNoteBloc(
                  bloc,
                  note,
                ),
                notesBloc: bloc,
              ),
            ),
          );
        },
        onLongPress: () async {
          final result = await showConfirmationDialog(
            context,
            AppLocalizations.of(context).noteDeleteConfirm(note.title),
          );
          if (result) {
            bloc.deleteNote(note.id);
          }
        },
      );
}
