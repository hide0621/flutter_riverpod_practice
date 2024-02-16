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

final futureProvider = FutureProvider<String>((ref) async {
  await Future.delayed(const Duration(seconds: 3));
  return 'Hello Future Riverpod!';
});

class RiverpodSample extends ConsumerWidget {
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FutureProviderのオブジェクトをキャッチする
    final value = ref.watch(futureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Sample'),
      ),
      body: Center(
        child: value.when(
            // dataプロパティには非同期処理が完了した時に表示するウィジェット（Text部分）を返す「コールバック関数」
            // (return 'Hello Future Riverpod!';の部分)を渡す
            data: (data) {
              return Text(
                data.toString(),
                style: const TextStyle(fontSize: 24),
              );
            },
            // errorプロパティには非同期処理に失敗した時に表示するウィジェット（Text部分）
            // を返すコールバック関数（以下の(error, trace)と言う無名関数）を渡す
            error: (error, trace) => Text(
                  error.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
            // loadingプロパティには非同期処理を実行している時に表示するウィジェット（CircularProgressIndicator部分）
            // を返す「コールバック関数」（以下の()と言う無名関数）を渡す
            loading: () => const CircularProgressIndicator()),
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
