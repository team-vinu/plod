part of plod;

abstract class PlodConsumerWidget extends StatelessWidget {
  const PlodConsumerWidget({Key? key, required this.plodChain})
      : super(key: key);

  final PlodChain plodChain;

  @override
  Widget build(BuildContext context) {
    return PlodScope(
      plodChain: plodChain,
      ok: onSuccess,
      loading: onLoading,
      err: onFailure,
    );
  }

  Widget onSuccess(BuildContext context, WidgetRef ref);
  Widget onLoading(BuildContext context, WidgetRef ref);
  Widget onFailure(
      BuildContext context, WidgetRef ref, Object error, StackTrace stackTrace);
}
