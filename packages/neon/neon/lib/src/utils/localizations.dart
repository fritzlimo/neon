import 'dart:ui';

import 'package:intl/intl_standalone.dart';
import 'package:meta/meta.dart';
import 'package:neon/l10n/localizations.dart';

/// Loads the [AppLocalizations] for the system [Locale].
///
/// When the system locale is not supported [fallbackLocale] will be used.
@internal
Future<AppLocalizations> appLocalizationsFromSystem([final Locale fallbackLocale = const Locale('en', 'US')]) async {
  final systemLocale = await findSystemLocale();
  final parts = systemLocale.split('_').map((final a) => a.split('.')).expand((final e) => e).toList();
  final locale = Locale(parts[0], parts.length > 1 ? parts[1] : null);

  final isSupported = AppLocalizations.delegate.isSupported(locale);

  return AppLocalizations.delegate.load(isSupported ? locale : fallbackLocale);
}
