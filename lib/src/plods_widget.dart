part of plod;

abstract class PlodsConsumerWidget extends StatelessWidget {
  const PlodsConsumerWidget(this.plods, {Key? key}) : super(key: key);

  final Plods plods;

  @override
  Widget build(BuildContext context) {
    return PlodsScope(
      plods: plods,
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
