import 'package:sample/src/model/repository/local/pref_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'view_conf.g.dart';

@riverpod //line spacing size
class ViewSpacingState extends _$ViewSpacingState {
  @override
  double build() {
    final spacing = PrefProvider.viewSpacing;
    ref.listenSelf((previous, next) {
      PrefProvider.viewSpacing = next;
    });
    return spacing;
  }

  void set(double v) => state = v;
}

@riverpod // fontsize
class ViewFontsizeState extends _$ViewFontsizeState {
  @override
  double build() {
    final fontsize = PrefProvider.viewFontsize;
    ref.listenSelf((previous, next) {
      PrefProvider.viewFontsize = next;
    });
    return fontsize;
  }

  void set(double v) => state = v;
}
