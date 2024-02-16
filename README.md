# flutter_riverpod_practice

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

こちらの教材を使用しています

[Flutter Riverpod 2.0: The Ultimate Guide](https://codewithandrea.com/articles/flutter-state-management-riverpod/)

また、この記事も良さそう（上記教材を噛み砕いているイメージ）

[Flutter Riverpod 入門](https://zenn.dev/naoya_maeda/articles/a8bbf40a202c74)

# Riverpodの使い方

まず最初に、[pub.dev](https://pub.dev/packages/flutter_riverpod)を見て最新のRiverpodのバージョンを調べ、それが分かったら`pubspec.yaml`の`dependencies`に[この記事](https://zenn.dev/naoya_maeda/articles/a8bbf40a202c74#flutter_riverpod%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)みたいに追記する

その後、`flutter pub get`コマンドを実行することでRiverpodがプロジェクトに追加される

次に、[この記事](https://zenn.dev/naoya_maeda/articles/a8bbf40a202c74#%E3%83%AB%E3%83%BC%E3%83%88%E3%81%ABproviderscope%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B)のように、`main関数`の`runApp関数`の引数に、

定数コンストラクタである`ProviderScope()`を記述し、この引数に`child: MyApp()`とのように記述することで、アプリ全体でProviderを利用できるようになる

より詳しく言うと、上位Widgetの`MyApp()`（`MyApp`は`StatelessWidget`を**継承**、つまり**Wrap**しているので）を囲むことで、MyApp以降のWidgetでもProviderを呼び出すことができる


# refについて

`ref`はラムダ式（無名関数）の引数

この`ref`引数は`ProviderReference型のオブジェクト`で、他のプロバイダーを参照したり、リソースのクリーンアップをスケジュールしたりするためのメソッドを提供する

具体的には、以下のような使い方がある：

`ref.watch(anotherProvider)`：`anotherProvider`の現在の値を取得し、`anotherProvider`の値が変更されるたびにこのプロバイダーを再計算します。

`ref.read(anotherProvider)`：`anotherProvider`の現在の値を取得しますが、`anotherProvider`の値が変更されてもこのプロバイダーは再計算されません。

`ref.onDispose(callback)`：プロバイダーが破棄されるときに実行するクリーンアップコードをスケジュールします。

# key部分について

`const RiverpodSample({Key? key}) : super(key: key);`

このコードは以下のような内容になっている

このコンストラクタは、`RiverpodSample`という名前の**新しいウィジェット**（**オブジェクト**）を生成し、

そのウィジェットは`Riverpodのプロバイダー`からデータを読み取ることができます。

また、このウィジェットは、オプションで一意の`Key(Keyクラス型)`を持つことができます。

Flutterフレームワークはこの`key(Keyクラスのオブジェクト)`を使用して、**ウィジェットの同一性**を追跡して、**一意性を保証する**ことができる

**初期化リスト**「**:**」があるので、*親クラスのコンストラクタが先に実行され、*

*その後にこのクラス（子クラス）のコンストラクタが実行される*

*子クラスのコンストラクタに渡されたkeyは、親クラスのコンストラクタに渡されるが、*

*初期化の手順は親クラスのコンストラクタが先に実行される*

この一連の流れ（つまりは、**keyは子クラスから親クラスに渡されるけど、初期化の順番は親クラスから**）により、*子クラスが親クラスのメソッドやプロパティを利用することができる*

---

# 各Providerの特徴についてはこの記事がわかりやすい

[Flutter 個人的Riverpodの理解まとめ](https://zenn.dev/wutchy_zenn/articles/a03dce8025fcf1#statenotifierprovider)

# Providerについて

`Provider`の特徴は...

⭐️一度定義すると状態が外部から変更できない。（**定数チック**）

⭐️初期化時点で他の`Provider`の値を参照して、その値を加工した値を`Provider`の値として保持することも可能。

⭐️グローバルな値を提供するために使われることが多い。

[このレポジトリでのサンプルコード](https://github.com/hide0621/flutter_riverpod_practice/blob/develop/lib/main.dart)

# StateNotifierProviderについて

`StateNotifierProvider`の特徴は...

⭐️状態を表す変数(`state`)と、状態を更新するメソッドを持つProvider。

⭐️`StateNotifier`を継承したクラスを監視して、**状態に変化があれば画面を更新する。**

⭐️高度な状態管理に向いている。

[このレポジトリでのサンプルコード](https://github.com/hide0621/flutter_riverpod_practice/blob/feature/pracitce-StateNotifierProvider/lib/main.dart)

# FutureProviderについて

⭐️`Future`型を取り扱うProvider。

⭐️**非同期データの取得**に使用して、データが使用可能（取得完了）になると`Widget`を更新する。

⭐️例としてAPIの呼び出しやSharedPreferencesなどの非同期処理など。

[このレポジトリでのサンプルコード](https://github.com/hide0621/flutter_riverpod_practice/blob/feature/practice-FutureProvider/lib/main.dart)

---

# 各Widgetについてもこの記事がわかりやすい

[Flutter 個人的Riverpodの理解まとめ 各Widgetについて](https://zenn.dev/wutchy_zenn/articles/a03dce8025fcf1#~%E5%90%84widget%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6~)

# ConsumerWidget

⭐️buildメソッド内でrefが参照できる。

⭐️Riverpod版のStatelessWidget。

# ConsumerStatefulWidget

⭐️State内からrefが参照できる。

⭐️Riverpod版のStatefulWidget。

