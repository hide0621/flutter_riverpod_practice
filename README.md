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

# refについて

`ref`はラムダ式（無名関数）の引数

この`ref`引数は`ProviderReference型のオブジェクト`で、他のプロバイダーを参照したり、リソースのクリーンアップをスケジュールしたりするためのメソッドを提供する

具体的には、以下のような使い方がある：

`ref.watch(anotherProvider)`：`anotherProvider`の現在の値を取得し、`anotherProvider`の値が変更されるたびにこのプロバイダーを再計算します。

`ref.read(anotherProvider)`：`anotherProvider`の現在の値を取得しますが、`anotherProvider`の値が変更されてもこのプロバイダーは再計算されません。

`ref.onDispose(callback)`：プロバイダーが破棄されるときに実行するクリーンアップコードをスケジュールします。
