part of 'screens.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String id = Get.arguments[0];
  String url = Get.arguments[1];

  TextEditingController text1;
  TextEditingController text2;

  @override
  void initState() {
    super.initState();
    text1 = TextEditingController();
    text2 = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    text1.dispose();
    text2.dispose();
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
        ),
        body: BlocBuilder<MemeCubit, MemeState>(builder: (context, state) {
          return ZStack([
            Image.network((state is GenerateTextMeme)
                    ? state.argumentUrl.url
                    : (tempUrl != null)
                        ? tempUrl
                        : url)
                .p16()
                .onTap(() {
              if (tempUrl != null) {
                context.read<ScreenCubit>().goToDownloadScreen();
              } else {
                Get.snackbar('Gagal Membuka',
                    'Silahkan menambahkan text terlebih dahulu');
              }
            }),
            (state is UploadLogoMeme)
                ? VxBox(
                    child: Image.file(
                      state.image,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ).p16(),
                  ).make()
                : (tempImage != null)
                    ? VxBox(
                        child: Image.file(
                          tempImage,
                          height: 60,
                          fit: BoxFit.cover,
                          width: 60,
                        ).p16(),
                      ).make()
                    : SizedBox(),
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
                        context.read<MemeCubit>().addImage();
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
                              text2: text2,
                              id: id,
                              url: url,
                            ));
                      },
                      icon: Icon(Icons.title),
                      label: 'Add Text'.text.make()),
                )
              ]).p16(),
            )
          ]);
        }),
      ),
    );
  }
}

class AddText extends StatefulWidget {
  final TextEditingController text1;
  final TextEditingController text2;
  final String id;
  final String url;

  const AddText({Key key, this.text1, this.text2, this.id, this.url})
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
          VxBox(
            child: TextField(
              controller: widget.text2,
              style:
                  textStyle.blackStyle1.copyWith(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter the second text',
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
                    if (widget.text1.text.isEmptyOrNull ||
                        widget.text2.text.isEmptyOrNull) {
                      Get.back();
                      Get.snackbar('Error', 'Please fill all fields');
                    } else {
                      context.read<MemeCubit>().sendMeme(widget.id, widget.url,
                          widget.text1.text, widget.text2.text);
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
