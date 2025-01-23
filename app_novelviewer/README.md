# app_novelviewer
    適当構造だからアーキテクチャもくそもない
## ToDo
modelのデータクラスと表示UIようクラス分離

## Directories
- main.dart
- src : ソースコード
    - app.dart
    - view : ui,表示関連
    - model : 内部処理等
        - repository
            - local : ローカルデータ関連
            - remote : web,API関連
        - logic : 内部ロジック
    - provider(view-model(view内のstateを分離,データバインディング？))

## devices
- android
- (ios?)

## ref
- アーキテクチャ
    - [flutterでのアーキテクチャ](https://zenn.dev/namioto/articles/4ff020a6835ea9)
    - [mvvm in flutter](https://qiita.com/homio/items/80ce1636a5da7c5b83fc)
    - [--](https://zenn.dev/alesion/articles/ab2df82a3809b7)

- 状態管理
    - [riverpod](https://zenn.dev/rmassu/articles/34dc1fed003d3e)
    - [riverpod_family](https://qiita.com/TakahiroOta/items/ed37a33fe0ee8b06bc29)
    - [riverpod_generator](https://zenn.dev/flutteruniv_dev/articles/riverpod_generator_in_action)
    - [riverpod_mvvm](https://zenn.dev/yosefstar/articles/78d16d1ecd1f34)
    - [riverpod_generator](https://zenn.dev/koichi_51/articles/e98d13089d5ad3)
    

- 画面遷移
    - [Navigation](https://yakiimosan.com/flutter-navigator/#index_id2)
    - [Navigation.pop()再描画](https://qiita.com/sjiro/items/d2bbceac0c27c71f7b2e)

- データ管理
    - [ローカルストレージ](https://engineering.webstudio168.jp/2022/02/flutter-local-storage)

- 非同期処理
    - [FutureBuilder](https://qiita.com/ysknsn/items/76c6326c74dc9059ff20)
    - [Future型について](https://flutter.salon/flutter/future-reload/)
    - [Isolate or Future](https://medium.com/flutter-jp/isolate-a3f6eab488b5)

- http
    - [http.get で headers:{'Access-Control-Allow-Origin':'*'}](https://qiita.com/naogify/items/e1f28a00741ba628c186)
    - [htmlから情報取得](https://note.com/hatchoutschool/n/n78a92d07f654)
    - [403エラー](https://qiita.com/Octoparse_Japan/items/1faac7a19091a5964e2d)

- その他
    - [参考資料](https://zenn.dev/nameless_sn/articles/recommended_flutter_repositories)
    - [dir構成](https://zenn.dev/web_tips/articles/530d02aaf90400)