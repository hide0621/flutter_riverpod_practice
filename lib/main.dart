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

//Providerをグローバル変数として定義する
//Providerとはデータを管理する入れ物のようなクラスで。文字列'Hello, Riverpod!'を保持する状態を作成している
//この例では、String型のデータである'Hello, Riverpod!'を管理するProviderを定義している
//refは、他のプロバイダーを参照するために使用できるProviderReferenceオブジェクトであり、ラムダ式の引数である
//refはラムダ式の引数（パラメータ）であり、関数本体（つまり、評価される式）は「'Hello, Riverpod!'」であり、
//このラムダ式は呼び出されると常に「'Hello, Riverpod!'」を返す
final strProvider = Provider((ref) => 'Hello, Riverpod!');

//Providerからデータを取得する
class RiverpodSample extends ConsumerWidget {
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
