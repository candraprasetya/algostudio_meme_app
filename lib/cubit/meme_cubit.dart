import 'dart:io';

import 'package:algostudio_test_app/models/models.dart';
import 'package:algostudio_test_app/utils/utils.dart';
import 'package:algostudio_test_app/widgets/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

part 'meme_state.dart';

class MemeCubit extends Cubit<MemeState> {
  MemeCubit() : super(MemeInitial());

  Future<List> getMemes() async {
    var response = await Dio().get('https://api.imgflip.com/get_memes');
    return response.data['data']['memes'];
  }

  void check() async {
    List memes = await getMemes();
    if (memes != null) {
      Get.offAndToNamed('/home');
      emit(GettingMemes(memes));
    } else {
      emit(ErrorGettingMemes());
    }
  }

  void addText(List<Widget> widgets, {Size size, String text}) {
    widgets.add(TransformWidget(
      height: size.height,
      width: size.width,
      text: text,
    ));
    emit(WidgetMemeState(widgets));
  }

  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  void saveMeme(GlobalKey globalKey) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List png = byteData.buffer.asUint8List();
      await ImageGallerySaver.saveImage(png);
      Get.snackbar("Saving Meme", "Berhasil di simpan ke gallery");
      emit(SavingMemeState(png));
    } catch (e) {
      Get.snackbar("Saving Meme", "Gagal menyimpan ke gallery");
    }
  }

  Future refresh() async {
    List memes = await getMemes();
    if (memes != null) {
      emit(GettingMemes(memes));
    } else {
      emit(ErrorGettingMemes());
    }
  }

  void shareToFriends(GlobalKey globalKey) async {
    try {
      ShareFilesAndScreenshotWidgets().shareScreenshot(
          globalKey, 800, "Title", "Meme.png", "image/png",
          text: "Saya punya meme lucu!");
    } catch (e) {
      Get.snackbar("Saving Meme", "Gagal mengirim");
    }
  }

  Future addImage(List<Widget> widgets, {Size size}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(UploadLogoMeme(File(pickedFile.path)));
      tempImage = File(pickedFile.path);
      widgets.add(TransformWidget(
        file: tempImage,
        height: size.height,
        width: size.width,
        isText: false,
      ));
    } else {
      print('No image selected.');
    }
  }

  Future sendMeme(
      String id, String url, String firstLine, String secondLine) async {
    // ignore: non_constant_identifier_names
    final String template_id = id;
    final String username = 'cobaaja2021';
    final String password = 'cobaaja123*';
    final String text0 = firstLine;
    final String text1 = secondLine;

    var response = await Dio().get(
        'https://api.imgflip.com/caption_image?template_id=$template_id&text0=$text0&text1=$text1&username=$username&password=$password');

    if (response.statusCode == 200) {
      emit(GenerateTextMeme(ArgumentUrl(
        id: template_id,
        url: response.data['data']['url'],
      )));
      tempUrl = response.data['data']['url'];
    } else {
      throw Exception('Failed to load memes');
    }
  }
}
