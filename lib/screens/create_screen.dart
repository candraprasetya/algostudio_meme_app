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
