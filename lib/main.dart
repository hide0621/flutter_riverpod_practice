import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ルートにProviderScopeを追加する
// こうすることで、アプリ全体でProviderを利用できる
// （上位WidgetのMyApp()を囲むことで、MyApp以降のWidgetでもProviderを呼び出すことができる）
void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RiverpodSample(),
    );
  }
}

// Providerは外部から変更することができないデータを管理するためのものであり（下のコードだとHello, Riverpod!）、
// このデータは、アプリケーション全体で共有される

//Providerをグローバル変数として定義する
//Providerとはデータを管理する入れ物のようなクラスで、文字列'Hello, Riverpod!'を保持する状態を作成している
//この例では、String型のデータである'Hello, Riverpod!'を管理するProviderを定義している
//Providerは、データを提供するためのものであり、データを提供するための関数をラムダ式で指定する
//refは、他のプロバイダーを参照するために使用できるProviderReferenceオブジェクトであり、ラムダ式の引数である
//refはラムダ式の引数（パラメータ）であり、関数本体（つまり、評価される式）は「'Hello, Riverpod!'」であり、
//このラムダ式は呼び出されると常に「'Hello, Riverpod!'」を返す
final strProvider = Provider((ref) => 'Hello, Riverpod!');

//Providerからデータを取得する
// Providerからデータを取得するためにConsumerWidget を使用する
// ConsumerWidget を継承したWidget（今回はRiverpodSample）を定義すると、build() にWidgetRef 型の引数が追加できる
class RiverpodSample extends ConsumerWidget {
  // このコンストラクタは、RiverpodSampleという名前の新しいウィジェット（オブジェクト）を生成し、
  // そのウィジェットはRiverpodのプロバイダーからデータを読み取ることができます。
  // また、このウィジェットは、オプションで一意のKeyを持つことができます。
  // Flutterフレームワークはこのkeyを使用して、ウィジェットの同一性を追跡して、一意性を保証することができる
  // 初期化リスト「:」があるので、親クラスのコンストラクタが先に実行され、
  // その後にこのクラスのコンストラクタが実行される
  // 子クラスのコンストラクタに渡されたkeyは、親クラスのコンストラクタに渡されるが、
  // 初期化の手順は親クラスのコンストラクタが先に実行される
  // この一連の流れにより、子クラスが親クラスのメソッドやプロパティを利用することができる
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ProviderにstrProvider を指定しているので、strProvider が管理しているデータである'Hello Riverpod' を取得することができる
    final value = ref.watch(strProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Sample'),
      ),
      body: Center(
          child: Text(
        value,
        style: const TextStyle(fontSize: 24),
      )),
    );
  }
}

//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
