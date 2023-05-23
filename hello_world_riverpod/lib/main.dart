import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// We create a "provider", which will a value (here "Hello wordl").
// By using a provder, this allows us to mock/override the value exposed.
final helloWorldProvider = Provider((_) => 'Hello World!');
void main() {
  // For widgets to be able to read providers, we need to wrap the entire
  // application in a "ProviderScope" sidget.
  // This is where state of out providers will be store
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Extend ConsumerWidget instead of StatelesWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Text(
            value,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ),
    );
  }
}
