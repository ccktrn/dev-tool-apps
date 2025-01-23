// ** ユーザー設定画面 ** //

import 'package:sample/src/view/importer.dart';
import 'package:sample/src/provider/provider/pref/theme_conf.dart';
import 'package:sample/src/provider/provider/pref/view_conf.dart';
import 'package:sample/src/view/component/dialog/select_dialog.dart';
import 'package:flutter/material.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late String _version;

  @override
  void initState() {
    super.initState();
    _version = "1.0.0-debug";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text(AppText.name),
      ),
      body: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children:
                ListTile.divideTiles(
                  context: context,
                  tiles: [
                    // View settings
                    ListTile(
                      subtitle: const Text(SettingsPageText.viewSection),
                      textColor: Theme.of(context).colorScheme.primary,
                    ),

                    ListTile(
                      // FontSize   デフォルトへの係数
                      leading: const Icon(Icons.format_size),
                      title: const Text(SettingsPageText.fontsize),
                      subtitle: Slider(
                        value: ref.watch(viewFontsizeStateProvider),
                        min: -5,
                        max: 5,
                        divisions: 10,
                        label:
                            "${ref.watch(viewFontsizeStateProvider) > 0 ? "+" : ""}${ref.watch(viewFontsizeStateProvider)}",
                        onChanged: _onChangeFontsize,
                      ),
                    ),
                    ListTile(
                      // spacing (space/letter)
                      leading: const Icon(Icons.unfold_more),
                      title: const Text(SettingsPageText.spacing),
                      subtitle: Slider(
                        value: ref.watch(viewSpacingStateProvider),
                        min: 0,
                        max: 5,
                        divisions: 10,
                        label: ref.watch(viewSpacingStateProvider).toString(),
                        onChanged: _onChangeSpacing,
                      ),
                    ),
                    Padding(
                      //textPreview
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        foregroundDecoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        padding: const EdgeInsets.all(15),
                        color: Theme.of(context).colorScheme.background,
                        child: Text(
                          SettingsPageText.previewText,
                          textScaler: TextScaler.linear(
                            1.1 *
                                (1 + ref.watch(viewFontsizeStateProvider) / 10),
                          ),
                          style: TextStyle(
                            height: 1 + ref.watch(viewSpacingStateProvider),
                          ),
                        ),
                      ),
                    ),

                    // Theme settings
                    ListTile(
                      subtitle: const Text(SettingsPageText.themeSection),
                      textColor: Theme.of(context).colorScheme.primary,
                    ),

                    ListTile(
                      // ThemeColor
                      leading: const Icon(Icons.colorize),
                      title: const Text(SettingsPageText.theme),
                      subtitle: Text(ref.watch(themeColorStateProvider).name),
                      onTap: _onTapThemeColor,
                    ),
                    ListTile(
                      // DarkMode
                      leading: const Icon(Icons.dark_mode_outlined),
                      title: const Text(SettingsPageText.themeMode),
                      subtitle: Text(ref.watch(themeModeStateProvider).name),
                      onTap: _onTapThemeMode,
                    ),

                    // Premium
                    ListTile(
                      subtitle: const Text(SettingsPageText.premiumSection),
                      textColor: Theme.of(context).colorScheme.primary,
                    ),

                    ListTile(
                      leading: const Icon(Icons.ad_units),
                      title: const Text(SettingsPageText.removeAds),
                      onTap: _onTapRemoveAds,
                    ),

                    // about App
                    ListTile(
                      subtitle: const Text(SettingsPageText.appSection),
                      textColor: Theme.of(context).colorScheme.primary,
                    ),

                    ListTile(
                      // vesions
                      leading: const Icon(Icons.precision_manufacturing),
                      title: const Text(SettingsPageText.version),
                      subtitle: Text(_version),
                      onTap: _onTapVersion,
                    ),
                    ListTile(
                      // poricy
                      leading: const Icon(Icons.policy_outlined),
                      title: const Text(SettingsPageText.policy),
                      onTap: _onTapPolicy,
                    ),
                  ],
                ).toList(),
          ),
        ),
      ),
    );
  }

  void _onChangeFontsize(double v) {
    ref.read(viewFontsizeStateProvider.notifier).set(v);
  }

  void _onChangeSpacing(double v) {
    ref.read(viewSpacingStateProvider.notifier).set(v);
  }

  void _onTapThemeColor() async {
    final ThemeColor? res = await showDialog(
      context: context,
      builder:
          (_) => SelectDialog(
            title: DialogText.selectThemeColorTitle,
            optNames: [for (final v in ThemeColor.values) v.name],
            optValues: ThemeColor.values,
          ),
    );
    if (res == null) {
      return;
    }
    ref.read(themeColorStateProvider.notifier).set(res);
  }

  void _onTapThemeMode() async {
    final ThemeMode? res = await showDialog(
      context: context,
      builder:
          (_) => SelectDialog(
            title: DialogText.selectThemeModeTitle,
            optNames: [for (final v in ThemeMode.values) v.name],
            optValues: ThemeMode.values,
          ),
    );
    if (res == null) {
      return;
    }
    ref.read(themeModeStateProvider.notifier).set(res);
  }

  void _onTapRemoveAds() async {}
  void _onTapVersion() async {
    showAboutDialog(
      context: context,
      applicationIcon: const Icon(Icons.abc), //AppIcon
      applicationName: AppText.name,
      applicationVersion: _version,
      applicationLegalese: "これ何かくん？",
    );
  }

  void _onTapPolicy() async {}
}
