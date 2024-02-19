import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final strProvider = Provider((ref) => 'Hello, Riverpod!');

// ConsumerStatefulWidgetにすることにより、
// buildメソッドの引数にrefを渡さずに、
// stateからrefを参照することができる（値を参照することができる）
class RiverpodSample extends ConsumerStatefulWidget {
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  ConsumerState<RiverpodSample> createState() => RiverpodSampleState();
}

class RiverpodSampleState extends ConsumerState<RiverpodSample> {
  // 以下のbuildの中のref部分のように、
  // buildメソッドの引数にrefを渡さずに、
  // stateからrefを参照することができる（値を参照することができる）
  @override
  Widget build(BuildContext context) {
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
