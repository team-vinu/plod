part of plod;

typedef NoArgPlodType<T> = PlodType<T, void>;
typedef PlodArgTuple<T, U> = Tuple2<PlodType<T, U>, PlodsArg<U>>;

typedef NoArg = void;
const NoArg noArg = null;
