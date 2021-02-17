part of 'screens.dart';

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  GlobalKey globalKey = GlobalKey();
  double top = Get.arguments[0];
  double left = Get.arguments[1];

  @override
  void initState() {
    super.initState();
    context.read<MemeCubit>().requestPermission();
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
                      ? Positioned(
                          top: top,
                          left: left,
                          child: VxBox(
                            child: Image.file(
                              tempImage,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ).make(),
                        )
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
                          primary: color.primary),
                      onPressed: () {
                        context.read<MemeCubit>().saveMeme(globalKey);
                      },
                      icon: Icon(Icons.save),
                      label: 'Simpan'.text.make()),
                ),
                16.widthBox,
                Expanded(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          elevation: 0.0,
                          primary: color.secondary),
                      onPressed: () {
                        context.read<MemeCubit>().shareToFriends(globalKey);
                      },
                      icon: Icon(Icons.share),
                      label: 'Share'.text.make()),
                )
              ]).p16(),
            )
          ]);
        }),
      ),
    );
  }
}
