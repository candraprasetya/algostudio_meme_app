part of 'screens.dart';

class ShareScreen extends StatefulWidget {
  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Vx.black),
          title: 'Share Meme'
              .text
              .textStyle(textStyle.blackStyle1)
              .maxLines(1)
              .make(),
        ),
        body: BlocBuilder<MemeCubit, MemeState>(builder: (context, state) {
          return ZStack([
            RepaintBoundary(
              key: globalKey,
              child: Material(
                child: ZStack([
                  Image.network(tempUrl).p16(),
                  (tempImage != null)
                      ? VxBox(
                          child: Image.file(
                            tempImage,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ).p16(),
                        ).make()
                      : SizedBox(),
                ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: HStack([
                Expanded(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          elevation: 0.0,
                          primary: color.secondary),
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.facebook),
                      label: 'Facebook'.text.make()),
                ),
                16.widthBox,
                Expanded(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          elevation: 0.0,
                          primary: color.accent),
                      onPressed: () {},
                      icon: Icon(Icons.title),
                      label: 'Twitter'.text.make()),
                )
              ]).p16(),
            )
          ]);
        }),
      ),
    );
  }
}
