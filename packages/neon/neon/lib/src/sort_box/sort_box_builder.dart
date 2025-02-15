import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sort_box/sort_box.dart';

/// Signature for a function that creates a widget for a given sorted list.
///
/// Used by [SortBoxBuilder] to display a sorted list of items.
typedef SortBoxWidgetBuilder<T> = Widget Function(BuildContext context, List<T> sorted);

/// Sorted list builder.
///
/// Used together with a [SortBox] to sort a given list.
class SortBoxBuilder<T extends Enum, R> extends StatelessWidget {
  /// Creates a new sort box builder.
  SortBoxBuilder({
    required this.sortBox,
    required this.sortProperty,
    required this.sortBoxOrder,
    required final List<R>? input,
    required this.builder,
    this.presort,
    super.key,
  }) : input = input ?? [];

  /// The box containing all sorting properties.
  final SortBox<T, R> sortBox;

  /// The property to sort on.
  final ValueListenable<T> sortProperty;

  /// The sorting order applied to the [sortProperty].
  final ValueListenable<SortBoxOrder> sortBoxOrder;

  /// Input list to sort.
  final List<R> input;

  /// Child builder using the sorted list.
  final SortBoxWidgetBuilder<R> builder;

  /// Pre sorts input.
  final Set<(T property, SortBoxOrder order)>? presort;

  @override
  Widget build(final BuildContext context) {
    if (input.length <= 1) {
      // input is already sorted.
      return builder(context, input);
    }

    return ValueListenableBuilder<T>(
      valueListenable: sortProperty,
      builder: (final context, final property, final _) => ValueListenableBuilder<SortBoxOrder>(
        valueListenable: sortBoxOrder,
        builder: (final context, final order, final _) {
          final box = (property, order);

          return builder(context, sortBox.sort(input, box, presort));
        },
      ),
    );
  }
}
