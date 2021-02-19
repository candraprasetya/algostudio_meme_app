part of 'screens.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String id = Get.arguments[0];
  String url = Get.arguments[1];
  List<Widget> widgets = [];
  TextEditingController text1;
  GlobalKey globalKey = GlobalKey();
  GlobalKey screenshotKey = GlobalKey();
  Size sizenya;
  @override
  void initState() {
    super.initState();
    text1 = TextEditingController();
    widgets.add(Image.network(url));
  }

  @override
  void dispose() {
    super.dispose();
    text1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<MemeCubit>().refresh();
        Get.back();
        setState(() {
          tempImage = null;
          tempUrl = null;
        });
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Vx.black),
          title: 'Create Meme'
              .text
              .textStyle(textStyle.blackStyle1)
              .maxLines(1)
              .make(),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                context.read<MemeCubit>().saveMeme(screenshotKey);
              },
            )
          ],
        ),
        body: BlocBuilder<MemeCubit, MemeState>(builder: (context, state) {
          return VStack(
            [
              WidgetSize(
                key: globalKey,
                onChange: (size) {
                  setState(() {
                    sizenya = size;
                  });
                },
                child: VxBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: RepaintBoundary(
                        key: screenshotKey, child: ZStack(widgets)),
                  ),
                ).make(),
              ).p24(),
              Align(
                alignment: Alignment.bottomCenter,
                child: HStack([
                  Expanded(
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(16),
                            elevation: 0.0,
                            primary: color.secondary),
                        onPressed: () {
                          context
                              .read<MemeCubit>()
                              .addImage(widgets, size: sizenya);
                        },
                        icon: Icon(Icons.image),
                        label: 'Add Image'.text.make()),
                  ),
                  16.widthBox,
                  Expanded(
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(16),
                            elevation: 0.0,
                            primary: color.accent),
                        onPressed: () {
                          context.read<ScreenCubit>().openBottomSheet(AddText(
                                text1: text1,
                                id: id,
                                url: url,
                                sizenya: sizenya,
                                widgets: widgets,
                              ));
                        },
                        icon: Icon(Icons.title),
                        label: 'Add Text'.text.make()),
                  )
                ]).p16(),
              )
            ],
          ).scrollVertical();
        }),
      ),
    );
  }
}

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const WidgetSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}

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
                      setState(() {
                        context.read<MemeCubit>().addText(widget.widgets,
                            size: widget.sizenya, text: widget.text1.text);
                      });
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
