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

//StateNotifierProvider で管理するStateNotifier のサブクラス（CounterNotifier）を実装する
//外部からデータを変更する時はこのサブクラス内のメソッドを呼び出す
//このプロバイダーの特徴は...
//状態を表す変数(state)と、状態を更新するメソッドを持つProvider。
//StateNotifierを継承したクラスを監視して、状態に変化があれば画面を更新する。
//高度な状態管理に向いている。
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}

// StateNotifierProvider を作成する
// StateNotifierProvider を定義する時は
// StateNotifierProvider の後に<管理するStateNotifier のサブクラス名, StateNotifier で管理するデータの型>が必要
// このStateNotifierProvider を使ってStateNotifier のサブクラスを取得することができる　→ Go言語のファクトリー関数っぽいけど、厳密には違う？
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class RiverpodSample extends ConsumerWidget {
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // StateNotifier のサブクラスはWidgetRef クラスのwatch() またはread() の引数に
    // StateNotifierProvider インスタンスの.notifier を指定することで取得することができる
    final countStateController = ref.read(counterProvider.notifier);
    // StateNotifier のサブクラスのデータ(state )はWidgetRef クラスのwatch() またはread() の引数に
    // StateNotifierProvider インスタンスを指定することで取得することができる
    // Providerで管理しているデータをwatch() で取得した時は、データの変更がウィジェットに通知され、ウィジェットがリビルドされる
    // フローティングボタンをタップするとデータに変更が入り、RiverpodSample ウィジェットがリビルドされることで画面に表示しているテキストを更新している
    final count = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Sample'),
      ),
      body: Center(
        child: Text(
          count.toString(),
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countStateController.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
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
