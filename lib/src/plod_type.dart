part of plod;

abstract class PlodType<T, U> {
  PlodType(this.loadingFunc);

  final FutureOr<T> Function(U) loadingFunc;
  Option<T> _valueOption = const Option.none();

  Future<void> load(U arg) async {
    _valueOption = Option.of(await loadingFunc(arg));
  }

  toTuple(U arg) {
    return PlodArgTuple(this, PlodsArg(arg));
  }
}
