import 'package:app_novelviewer/src/model/repository/local/pref_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'custom_conf.g.dart';

@riverpod
class DefaultURL extends _$DefaultURL {
  @override
  String build() {
    final url = PrefProvider.defaultURL;
    ref.listenSelf((previous, next) {
      PrefProvider.defaultURL = next;
    });
    return url;
  }

  void set(String v) => state = v;
}

@riverpod
class CustomButtons extends _$CustomButtons {
  @override
  List<String> build() {
    final buttons = PrefProvider.customButtons;
    ref.listenSelf((previous, next) {
      PrefProvider.customButtons = next;
    });
    return buttons;
  }

  void set(List<String> v) => state = v;
}
