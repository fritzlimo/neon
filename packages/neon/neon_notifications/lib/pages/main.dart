part of '../neon_notifications.dart';

class NotificationsMainPage extends StatefulWidget {
  const NotificationsMainPage({
    super.key,
  });

  @override
  State<NotificationsMainPage> createState() => _NotificationsMainPageState();
}

class _NotificationsMainPageState extends State<NotificationsMainPage> {
  late NotificationsBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = NeonProvider.of<NotificationsBlocInterface>(context) as NotificationsBloc;

    bloc.errors.listen((final error) {
      NeonError.showSnackbar(context, error);
    });
  }

  @override
  Widget build(final BuildContext context) => ResultBuilder<List<NotificationsNotification>>.behaviorSubject(
        stream: bloc.notifications,
        builder: (final context, final notifications) => Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: StreamBuilder<int>(
            stream: bloc.unreadCounter,
            builder: (final context, final snapshot) {
              final unreadCount = snapshot.data ?? 0;
              return FloatingActionButton(
                onPressed: unreadCount > 0 ? bloc.deleteAllNotifications : null,
                tooltip: AppLocalizations.of(context).notificationsDismissAll,
                child: const Icon(MdiIcons.checkAll),
              );
            },
          ),
          body: NeonListView(
            scrollKey: 'notifications-notifications',
            isLoading: notifications.isLoading,
            error: notifications.error,
            onRefresh: bloc.refresh,
            itemCount: notifications.data?.length,
            itemBuilder: (final context, final index) => _buildNotification(context, notifications.data![index]),
          ),
        ),
      );

  Widget _buildNotification(
    final BuildContext context,
    final NotificationsNotification notification,
  ) {
    final app = NeonProvider.of<Iterable<AppImplementation>>(context).tryFind(notification.app);

    return ListTile(
      title: Text(notification.subject),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (notification.message.isNotEmpty) ...[
            Text(
              notification.message,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
          RelativeTime(
            date: DateTime.parse(notification.datetime),
          ),
        ],
      ),
      leading: app != null
          ? app.buildIcon(
              size: largeIconSize,
            )
          : SizedBox.fromSize(
              size: const Size.square(largeIconSize),
              child: NeonCachedImage.url(
                url: notification.icon!,
                size: const Size.square(largeIconSize),
                svgColorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
            ),
      onTap: () async {
        if (notification.app == AppIDs.notifications) {
          return;
        }
        if (app != null) {
          // TODO: use go_router once implemented
          final accountsBloc = NeonProvider.of<AccountsBloc>(context);
          await accountsBloc.activeAppsBloc.setActiveApp(app.id);
        } else {
          final colorScheme = Theme.of(context).colorScheme;

          await showDialog<void>(
            context: context,
            builder: (final context) => AlertDialog(
              title: Text(AppLocalizations.of(context).notificationAppNotImplementedYet),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).actionClose),
                ),
              ],
            ),
          );
        }
      },
      onLongPress: () {
        bloc.deleteNotification(notification.notificationId);
      },
    );
  }
}
