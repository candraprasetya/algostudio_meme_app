part of 'widgets.dart';

class AddText extends StatefulWidget {
  final TextEditingController text1;
  final String id;
  final String url;
  final Size sizenya;
  final List<Widget> widgets;

  const AddText(
      {Key key, this.sizenya, this.widgets, this.text1, this.id, this.url})
      : super(key: key);

  @override
  _AddTextState createState() => _AddTextState();
}

class _AddTextState extends State<AddText> {
  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: VStack([
          'Add Text'.text.textStyle(textStyle.blackStyle1).xl.make().p16(),
          VxBox(
            child: TextField(
              controller: widget.text1,
              style:
                  textStyle.blackStyle1.copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter the first text',
                  hintStyle: textStyle.blackStyle1.copyWith(
                      fontWeight: FontWeight.normal, color: Vx.gray600)),
            ).pSymmetric(h: 12),
          ).white.withRounded(value: 10).make().p12(),
          ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      elevation: 0.0,
                      primary: color.primary),
                  onPressed: () {
                    if (widget.text1.text.isEmptyOrNull) {
                      Get.back();
                      Get.snackbar('Error', 'Please fill all fields');
                    } else {
                      context.read<MemeCubit>().addText(widget.widgets,
                          size: widget.sizenya, text: widget.text1.text);

                      Get.back();
                    }
                  },
                  icon: Icon(Icons.send),
                  label: 'Finish'.text.make())
              .p16()
              .wFull(context),
        ]).scrollVertical());
  }
}
