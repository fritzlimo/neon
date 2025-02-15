import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:neon/src/utils/relative_time.dart';

/// Shows the time elapsed since a [DateTime] and periodically updates itself.
class RelativeTime extends StatefulWidget {
  /// Creates a new relative DateTime widget.
  const RelativeTime({
    required this.date,
    this.style,
    super.key,
  });

  /// The timestamp to be displayed.
  final DateTime date;

  /// The text style of the calculated time.
  ///
  /// If not specified the nearest [TextStyle] will be used.
  final TextStyle? style;

  @override
  State<RelativeTime> createState() => _RelativeTimeState();
}

class _RelativeTimeState extends State<RelativeTime> {
  late final Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(minutes: 1),
      (final _) => setState(() {}),
    );

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Text(
        widget.date.formatRelative(),
        style: widget.style,
      );
}
