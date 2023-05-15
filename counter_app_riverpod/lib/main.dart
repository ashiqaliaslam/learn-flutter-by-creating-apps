import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // ProviderScope(child: const MyApp()),
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter app Riverpod',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CounterHomePage(
        title: 'Counter App with Riverpod',
      ),
    );
  }
}

final counterProvider = StateProvider((ref) => 0, name: 'counter');

class CounterHomePage extends ConsumerWidget {
  const CounterHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pressed this many times'),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 60),
            IconButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state = 0;
              },
              icon: const Icon(
                Icons.restart_alt,
              ),
              iconSize: 50,
              tooltip: 'Reset to zero',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
