part of '../neon_files.dart';

/// Mode to operate the [FilesBrowserView] in.
enum FilesBrowserMode {
  /// Default file browser mode.
  ///
  /// When a file is selected it will be opened or downloaded.
  browser,

  /// Select directory.
  selectDirectory,

  /// Don't show file actions.
  noActions,
}

class FilesBrowserView extends StatefulWidget {
  const FilesBrowserView({
    required this.bloc,
    required this.filesBloc,
    this.mode = FilesBrowserMode.browser,
    super.key,
  });

  final FilesBrowserBloc bloc;
  final FilesBloc filesBloc;
  final FilesBrowserMode mode;

  @override
  State<FilesBrowserView> createState() => _FilesBrowserViewState();
}

class _FilesBrowserViewState extends State<FilesBrowserView> {
  @override
  void initState() {
    widget.bloc.errors.listen((final error) {
      NeonError.showSnackbar(context, error);
    });

    super.initState();
  }

  @override
  Widget build(final BuildContext context) => ResultBuilder<List<WebDavFile>>.behaviorSubject(
        stream: widget.bloc.files,
        builder: (final context, final files) => StreamBuilder<List<String>>(
          stream: widget.bloc.path,
          builder: (final context, final pathSnapshot) => StreamBuilder<List<FilesTask>>(
            stream: widget.filesBloc.tasks,
            builder: (final context, final tasksSnapshot) => !pathSnapshot.hasData || !tasksSnapshot.hasData
                ? const SizedBox()
                : BackButtonListener(
                    onBackButtonPressed: () async {
                      final path = pathSnapshot.requireData;
                      if (path.isNotEmpty) {
                        widget.bloc.setPath(path.sublist(0, path.length - 1));
                        return true;
                      }
                      return false;
                    },
                    child: SortBoxBuilder<FilesSortProperty, WebDavFile>(
                      sortBox: filesSortBox,
                      sortProperty: widget.bloc.options.filesSortPropertyOption,
                      sortBoxOrder: widget.bloc.options.filesSortBoxOrderOption,
                      presort: const {
                        (FilesSortProperty.isFolder, SortBoxOrder.ascending),
                      },
                      input: files.data,
                      builder: (final context, final sorted) => ValueListenableBuilder(
                        valueListenable: widget.bloc.options.showHiddenFilesOption,
                        builder: (final context, final showHiddenFiles, final _) {
                          final uploadingTasks = tasksSnapshot.requireData
                              .whereType<FilesUploadTask>()
                              .where(
                                (final task) =>
                                    sorted.where((final file) => _pathMatchesFile(task.path, file.name)).isEmpty,
                              )
                              .toList();

                          return NeonListView(
                            scrollKey: 'files-${pathSnapshot.requireData.join('/')}',
                            itemCount: uploadingTasks.length + sorted.length,
                            itemBuilder: (final context, final index) {
                              if (index < uploadingTasks.length) {
                                return FileListTile(
                                  bloc: widget.filesBloc,
                                  browserBloc: widget.bloc,
                                  details: FileDetails.fromUploadTask(
                                    task: uploadingTasks[index],
                                  ),
                                );
                              }

                              final file = sorted[index - uploadingTasks.length];
                              if ((widget.mode != FilesBrowserMode.selectDirectory || file.isDirectory) &&
                                  (!file.isHidden || showHiddenFiles)) {
                                final matchingTask = tasksSnapshot.requireData
                                    .firstWhereOrNull((final task) => _pathMatchesFile(task.path, file.name));

                                final details = matchingTask != null
                                    ? FileDetails.fromTask(
                                        task: matchingTask,
                                        file: file,
                                      )
                                    : FileDetails.fromWebDav(
                                        file: file,
                                        path: widget.bloc.path.value,
                                      );

                                return FileListTile(
                                  bloc: widget.filesBloc,
                                  browserBloc: widget.bloc,
                                  details: details,
                                );
                              }

                              return null;
                            },
                            isLoading: files.isLoading,
                            error: files.error,
                            onRefresh: widget.bloc.refresh,
                            topScrollingChildren: [
                              FilesBrowserNavigator(
                                path: pathSnapshot.requireData,
                                bloc: widget.bloc,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ),
      );

  bool _pathMatchesFile(final List<String> path, final String name) => const ListEquality<String>().equals(
        [...widget.bloc.path.value, name],
        path,
      );
}
