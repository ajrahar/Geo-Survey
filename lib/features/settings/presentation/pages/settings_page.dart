import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/localization/locale_provider.dart';
import 'package:geosurvey/core/localization/l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final localeState = ref.watch(localeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              l10n.languageTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RadioGroup<String>(
            groupValue: localeState.locale.languageCode,
            onChanged: (value) {
              if (value != null) {
                ref
                    .read(localeControllerProvider.notifier)
                    .setLocale(Locale(value));
              }
            },
            child: Column(
              children: [
                RadioListTile<String>(
                  title: const Text('English'),
                  value: 'en',
                ),
                RadioListTile<String>(
                  title: const Text('Bahasa Indonesia'),
                  value: 'id',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
