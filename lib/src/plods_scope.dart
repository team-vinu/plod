part of plod;

class PlodsScope extends ConsumerWidget {
  const PlodsScope({
    Key? key,
    required this.plods,
    required this.ok,
    required this.loading,
    required this.err,
  }) : super(key: key);

  final Plods plods;
  final Widget Function(BuildContext, WidgetRef) ok;
  final Widget Function(BuildContext, WidgetRef) loading;
  final Widget Function(BuildContext, WidgetRef, Object, StackTrace) err;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(plods.asyncProvider).when(
          data: (plods) => Consumer(
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
