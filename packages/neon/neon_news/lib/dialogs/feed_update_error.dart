part of '../neon_news.dart';

class NewsFeedUpdateErrorDialog extends StatefulWidget {
  const NewsFeedUpdateErrorDialog({
    required this.feed,
    super.key,
  });

  final NewsFeed feed;

  @override
  State<NewsFeedUpdateErrorDialog> createState() => _NewsFeedUpdateErrorDialogState();
}

class _NewsFeedUpdateErrorDialogState extends State<NewsFeedUpdateErrorDialog> {
  @override
  Widget build(final BuildContext context) => AlertDialog(
        title: Text(widget.feed.lastUpdateError!),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(
                  text: widget.feed.lastUpdateError!,
                ),
              );
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context).feedCopiedErrorMessage),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            child: Text(AppLocalizations.of(context).feedCopyErrorMessage),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).actionClose),
          ),
        ],
      );
}
