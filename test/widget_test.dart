import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plod/plod.dart';

void main() async {
  testWidgets("widgetTest", (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: TestApp()));
    await tester.pumpAndSettle();

    expect(find.text("success"), findsOneWidget);
  });
}

class TestChain extends PlodChain {
  TestChain() {
    super.init(tupleList);
  }

  late final tupleList = <PlodArgTuple>[vp.toTuple(0)];

  final vp = ValuePlod((int a) async => a + 1);
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlodScope(
      plodChain: TestChain(),
      ok: (context, ref) {
        debugPrint("ok");
        return const Text("success");
      },
      loading: (context, ref) {
        debugPrint("loading");
        return const Text("loading");
      },
      err: (context, ref, error, stackTrace) {
        debugPrint("error");
        return const Text("error");
      },
    );
  }
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TestWidget(),
      ),
    );
  }
}
