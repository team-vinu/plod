part of plod;

class Plod<T> {
  Plod(
    Future<T> Function() loadingFunc,
  ) : _task = Task(loadingFunc);

  final Task<T> _task;
  Option<T> _valueOption = const Option.none();

  T get value => _valueOption.getOrElse(() => throw PlodNotLoadedError(this));

  @protected
  Future<void> load() async {
    final taskResult = await _task.run();
    _valueOption = Option.of(taskResult);
  }
}

class ResultPlod<T> extends Plod<T> {
  ResultPlod(
    Future<T> Function() loadingFunc,
  ) : super(loadingFunc);

  Option<Object> _errOption = const Option.none();
  Option<Object> get errOption => _errOption;
  Object? get e => _errOption.match(
        () => null,
        (e) => e,
      );

  @override
  Future<void> load() async {
    try {
      final taskResult = await _task.run();
      _valueOption = Option.of(taskResult);
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

class PlodNotLoadedError extends Error {
  PlodNotLoadedError(this.plod);

  final Plod plod;

  @override
  String toString() {
    return "PlodNotLoadedError: ${plod.runtimeType.toString()}";
  }
}
