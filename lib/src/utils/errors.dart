part of plod;

class PlodNotLoadedError extends Error {
  PlodNotLoadedError(this.plod);

  final PlodType plod;

  @override
  String toString() {
    return "PlodNotLoadedError: ${plod.runtimeType.toString()}";
  }
}

class PlodArgTupleNotRegisteredError extends Error {
  PlodArgTupleNotRegisteredError(this.plodChain);

  final PlodChain plodChain;

  @override
  String toString() {
    return "PlodArgTupleNotRegisteredError: ${plodChain.runtimeType.toString()}";
  }
}
