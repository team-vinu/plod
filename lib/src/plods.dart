part of plod;

class Plods {
  late final List<Plod> _list;
  late final AutoDisposeFutureProvider<void> asyncProvider;

  Plods(List<Plod> list) {
    _list = list;
    asyncProvider = AutoDisposeFutureProvider((ref) async {
      await Future.wait(_list.map((e) => e.load()));
    });
  }

  void registerOrder(List<Plod> order) {
    // if (_list.isNotEmpty) {
    //   throw Exception("Plods are already ordered.");
    // }
    _list.addAll(order);
  }

  void reload(WidgetRef ref) {
    ref.invalidate(asyncProvider);
  }
}
