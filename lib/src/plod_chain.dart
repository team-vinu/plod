part of plod;

abstract class PlodChain {
  late final AutoDisposeFutureProvider<void> futureProvider;
  var _listOption = const Option<List<PlodArgTuple>>.none();

  init(List<PlodArgTuple> list) {
    _listOption = Option.of(list);
    futureProvider = AutoDisposeFutureProvider((ref) async {
      _listOption.match(
        () => throw PlodArgTupleNotRegisteredError(this),
        (some) async {
          Future.wait(some.map((e) => e.first.load(e.second.value)));
        },
      );
    });
  }

  void reload(WidgetRef ref) {
    ref.invalidate(futureProvider);
  }
}
