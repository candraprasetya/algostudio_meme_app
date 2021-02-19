part of 'widgets.dart';

class TransformWidget extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final bool isText;
  final File file;

  const TransformWidget(
      {this.isText = true,
      this.file,
      this.text,
      Key key,
      this.height,
      this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    return MatrixGestureDetector(
      onMatrixUpdate: (m, tm, sm, rm) {
        notifier.value = m;
      },
      child: AnimatedBuilder(
        animation: notifier,
        builder: (ctx, child) {
          return Transform(
            transform: notifier.value,
            child: Container(
              height: height - context.percentHeight * 1,
              width: width,
              child: (isText)
                  ? Text(
                      text,
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    )
                  : Image.file(
                      file,
                      width: 60,
                      height: 60,
                    ),
            ),
          );
        },
      ),
    );
  }
}
