import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neon/src/bloc/result.dart';
import 'package:neon/src/bloc/result_builder.dart';
import 'package:neon/src/blocs/accounts.dart';
import 'package:neon/src/models/account.dart';
import 'package:neon/src/theme/sizes.dart';
import 'package:neon/src/utils/provider.dart';
import 'package:neon/src/widgets/image.dart';
import 'package:neon/src/widgets/server_icon.dart';
import 'package:nextcloud/nextcloud.dart';
import 'package:rxdart/rxdart.dart';

class NeonUserAvatar extends StatefulWidget {
  NeonUserAvatar({
    required this.account,
    final String? username,
    this.showStatus = true,
    this.size,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  }) : username = username ?? account.username;

  final Account account;
  final String username;
  final bool showStatus;
  final double? size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<NeonUserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<NeonUserAvatar> {
  late final _userStatusBloc = NeonProvider.of<AccountsBloc>(context).getUserStatusesBlocFor(widget.account);
  late double size;

  @override
  void initState() {
    super.initState();

    if (widget.showStatus) {
      unawaited(_userStatusBloc.load(widget.username));
    }
  }

  @override
  Widget build(final BuildContext context) => LayoutBuilder(
        builder: (final context, final constraints) {
          final brightness = Theme.of(context).brightness;
          size = constraints.constrain(Size.square(widget.size ?? largeIconSize)).shortestSide;
          final pixelSize = (size * MediaQuery.of(context).devicePixelRatio).toInt();

          final avatar = CircleAvatar(
            radius: size / 2,
            backgroundColor: widget.backgroundColor,
            child: ClipOval(
              child: NeonApiImage.custom(
                account: widget.account,
                cacheKey: 'avatar-${widget.username}-$brightness$pixelSize',
                getImage: (final client) async => switch (brightness) {
                  Brightness.dark => client.core.avatar.getAvatarDark(
                      userId: widget.username,
                      size: pixelSize,
                    ),
                  Brightness.light => client.core.avatar.getAvatar(
                      userId: widget.username,
                      size: pixelSize,
                    ),
                },
              ),
            ),
          );

          if (!widget.showStatus) {
            return avatar;
          }
          return Stack(
            alignment: Alignment.center,
            children: [
              avatar,
              ResultBuilder(
                stream: _userStatusBloc.statuses.mapNotNull((final statuses) => statuses[widget.username]),
                builder: _userStatusIconBuilder,
              ),
            ],
          );
        },
      );

  Widget _userStatusIconBuilder(final BuildContext context, final Result<UserStatusPublicInterface?> result) {
    final hasEmoji = result.data?.icon != null;
    final scaledSize = size / (hasEmoji ? 2 : 2.5);

    Widget? child;
    if (result.isLoading) {
      child = CircularProgressIndicator(
        strokeWidth: 1.5,
        color: widget.foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
      );
    } else if (result.hasError) {
      child = Icon(
        Icons.error_outline,
        size: scaledSize,
        color: Theme.of(context).colorScheme.error,
      );
    } else if (hasEmoji) {
      child = Text(
        result.data!.icon!,
        style: const TextStyle(
          fontSize: 16,
        ),
      );
    } else if (result.hasData) {
      child = NeonServerIcon(icon: 'user-status-${result.data!.status}');
    }

    return SizedBox.square(
      dimension: size,
      child: Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          width: scaledSize,
          height: scaledSize,
          child: child,
        ),
      ),
    );
  }
}
