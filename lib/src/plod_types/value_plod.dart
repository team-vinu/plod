part of plod;

class ValuePlod<T, U> extends PlodType<T, U> {
  ValuePlod(FutureOr<T> Function(U) loadingFunc) : super(loadingFunc);

  T get value => _valueOption.getOrElse(() => throw PlodNotLoadedError(this));

  static NoArgValuePlod<T> noArg<T>(FutureOr<T> Function() loadingFunc) {
    return NoArgValuePlod<T>(loadingFunc);
  }
}

class NoArgValuePlod<T> extends ValuePlod<T, void> {
  NoArgValuePlod(FutureOr<T> Function() loadingFunc)
      : super((_) => loadingFunc());
}

// temp
