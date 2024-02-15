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
