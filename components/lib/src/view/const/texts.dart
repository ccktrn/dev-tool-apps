


// text for around Apps
class AppText {
  static const String name = "ノベルリーダー";
}

class ConstText {

}

// text for pages
class HomePageText {
  static const title = "ノベルリーダー";
  static const novelsPageButton = "小説一覧";
  static const updatesPageButton = "更新一覧";
  static const serchPageButton = "小説を探す";
  static const homeInfoTitle = "最後に読んだ小説";
  static const noRecentReadMessage = "閲覧履歴が見つかりません";

  static const sidebars = [
    "設定",
    "データ管理",
    "ダウンロード履歴",
    "レビュー",
    "ヘルプ",
  ]; 
    
}
class NovelsPageText {
  static const title = "小説一覧";
  static const update = "更新";
  static const listEmptyMessage = "ダウンロード済みの小説はありません";

  static const tilemenus = ["目次を再取得","すべて再取得","この小説を削除"];

}
class EpisodesPageText {
  static const title = "エピソード一覧";
  static const update = "更新";
  static const nonViewed = "未読";
  static const viewed = "既読";
  static const listEmptyMessage = "エピソードはありません";

  static const sidebars = [
    "この小説を更新",
    "目次を再取得",
    "すべて再取得",
    "しおりを削除",
    "すべて既読",
    "すべて未読",
    "内部ブラウザで開く",
    "小説を削除",
  ];

  static const tilemenus = [
    "再取得",
    "既読/未読の切替",
    "ここまで既読にする"
  ];
}
class ReadPageText {
  static const textEmptyMessage = "本文データがありません";

  static const sidebarFontSize = "フォントサイズ"; 
  static const sidebarSpacing = "行間";
  static const sidebarDownload = "この話を再取得";
}

class WebViewPageText {
  static const title = "小説を探す";
}
class UpdatesPageText {
  static const title = "更新一覧";
  static const listEmptyMessage = "更新された小説はありません";

}

class SettingsPageText {
  static const title = "設定";

  static const themeSection = "Themes";
  static const viewSection = "View";
  static const customSection = "Custom options";
  static const premiumSection = "Premium";
  static const appSection = "about This App";

  static const fontsize = "フォントサイズ";
  static const spacing = "行間";
  static const theme = "テーマカラー";
  static const themeMode = "ダークモード";
  static const defaultURL = "デフォルトURL";
  static const customButtons = "カスタムボタン設定";
  static const removeAds = "広告の削除";
  static const version = "バージョン情報";
  static const policy = "プライバシーポリシー";

  static const previewText = "サンプルテキスト\nSample Text";
}

// text for dialog
class DialogText {
  static const yes = "はい";
  static const no = "いいえ";
  static const ok = "OK";
  static const cancel = "Cancel";

  static const deleteNovelTitle = "小説の削除";
  static const deleteNovelMessage = "本当に削除しますか？";
  static const addNovelTitle = "小説の追加";
  static const addNovelMessage = "登録する小説のURLを入力してください";
  static const addNovelExampleUrl = "https://novelsite.example/nv/";
  static const selectThemeModeTitle = "ダークモードの切替";
  static const selectThemeColorTitle = "テーマカラーの選択";
  static const defaultUrlTitle= "デフォルトURL設定";
  static const defaultUrlMessage= "${HomePageText.serchPageButton}で開くURLを入力してください";
  static const defaultUrlExampleUrl= "https://novelsite.example/";

} 

// text for snackbar
class SnackBarText {
  static const finished = "完了";
  static const registerd = "登録完了";
  static const unexpectedURL = "URLが間違っています";
  static const registeredURL = "既に登録済みです";
  static const deleted = "削除されています";
  static const networkerror = "ネットワークエラー";
}



