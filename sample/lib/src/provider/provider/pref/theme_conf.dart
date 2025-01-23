import 'package:sample/src/model/repository/local/pref_provider.dart';
import 'package:sample/src/view/const/themecolor.dart';
import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_conf.g.dart';

@riverpod
class ThemeColorState extends _$ThemeColorState {
  @override
  ThemeColor build() {
    final color = ThemeColor.values.byName(PrefProvider.themeColor);
    ref.listenSelf((previous, next) {
      PrefProvider.themeColor = next.name;
      // log("${previous?.name}=>${next.name}");
    });
    return color;
  }

  void set(ThemeColor v) => state = v;
}

@riverpod
class ThemeModeState extends _$ThemeModeState {
  @override
  ThemeMode build() {
    final mode = ThemeMode.values.byName(PrefProvider.themeMode);
    ref.listenSelf((previous, next) {
      PrefProvider.themeMode = next.name;
      // log("${previous?.name}=>${next.name}");
    });
    return mode;
  }

  void set(ThemeMode v) => state = v;
}
