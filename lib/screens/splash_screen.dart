part of 'screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<List> futureMemes;

  @override
  void initState() {
    super.initState();
  }

  void getMemes() async {
    var response = await Dio().get('https://api.imgflip.com/get_memes');

    if (response.statusCode == 200) {
      Get.offAndToNamed('/home',
          arguments: ScreenArguments(memes: response.data['data']['memes']));
    } else {
      throw Exception('Failed to load memes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.background,
      body: VStack(
        [
          Image.asset('assets/logo.png'),
          20.heightBox,
          HStack([
            'AlgoStudio'.text.textStyle(textStyle.blackStyle1).make(),
            'Meme'
                .text
                .textStyle(
                    textStyle.blackStyle1.copyWith(fontWeight: FontWeight.w300))
                .make()
          ])
        ],
        alignment: MainAxisAlignment.center,
        crossAlignment: CrossAxisAlignment.center,
      ).whFull(context),
    );
  }
}
