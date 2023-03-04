part of plod;

class ResultPlod<T, U> extends PlodType<T, U> {
  ResultPlod(FutureOr<T> Function(U) loadingFunc) : super(loadingFunc);

  Option<Object> _errOption = const Option.none();
  Option<Object> get errOption => _errOption;
  Object? get e => _errOption.match(
        () => null,
        (e) => e,
      );

  @override
  Future<void> load(U arg) async {
    try {
      _valueOption = Option.of(await loadingFunc(arg));
    } catch (e) {
      _valueOption = const Option.none();
      _errOption = Option.of(e);
    }
  }

  T valueOr(T Function(Object) orElse) {
    return _valueOption.getOrElse(() {
      return orElse(_errOption.getOrElse(() {
        throw PlodNotLoadedError(this);
      }));
    });
  }

  R maybeErr<R>({
    required R Function(T) ok,
    required R Function(Object) err,
  }) {
    return _valueOption.match(
      () => err(_errOption.getOrElse(() {
        throw PlodNotLoadedError(this);
      })),
      (value) => ok(value),
    );
  }

  R match<R>({
    required R Function(T) ok,
    required R Function(Object) err,
  }) {
    return maybeErr(ok: ok, err: err);
  }
}
