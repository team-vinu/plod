part of plod;

class PlodScope extends ConsumerWidget {
  const PlodScope({
    Key? key,
    required this.plodChain,
    required this.ok,
    required this.loading,
    required this.err,
  }) : super(key: key);

  final PlodChain plodChain;
  final Widget Function(BuildContext, WidgetRef) ok;
  final Widget Function(BuildContext, WidgetRef) loading;
  final Widget Function(BuildContext, WidgetRef, Object, StackTrace) err;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(plodChain.futureProvider).when(
          data: (_) => Consumer(
            key: key,
            builder: (context, ref, child) {
              return ok(context, ref);
            },
          ),
          loading: () => Consumer(
            key: key,
            builder: (context, ref, child) {
              return loading(context, ref);
            },
          ),
          error: (error, stackTrace) => Consumer(
            key: key,
            builder: (context, ref, child) {
              return err(context, ref, error, stackTrace);
            },
          ),
        );
  }
}
