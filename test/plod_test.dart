import 'package:flutter_test/flutter_test.dart';
import 'package:plod/plod.dart';

// sample
void main() async {
  test("plodTypeTest", () async {
    final v = ValuePlod<int, int>((i) async => i + 1);
    final vn = ValuePlod.noArg(() async => 1);

    await v.load(1);
    await vn.load(noArg);

    expect(v.value, 2);
    expect(vn.value, 1);
  });
}
