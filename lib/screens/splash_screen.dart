part of 'screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MemeCubit>().check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.background,
      body: BlocBuilder<MemeCubit, MemeState>(builder: (context, state) {
        if (state is ErrorGettingMemes) {
          return VStack(
            [
              Icon(
                Icons.error_outline,
                size: context.percentWidth * 10,
                color: Vx.red600,
              ),
              16.heightBox,
              'Check your connection'
                  .text
                  .textStyle(textStyle.blackStyle1)
                  .make(),
              ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          primary: color.primary),
                      onPressed: () => context.read<MemeCubit>().getMemes(),
                      child: 'Refresh'
                          .text
                          .textStyle(
                              textStyle.blackStyle1.copyWith(color: Vx.white))
                          .makeCentered())
                  .p16()
            ],
            alignment: MainAxisAlignment.center,
            crossAlignment: CrossAxisAlignment.center,
          ).whFull(context);
        }
        return VStack(
          [
            Image.asset('assets/logo.png'),
            20.heightBox,
            HStack([
              'AlgoStudio'.text.textStyle(textStyle.blackStyle1).make(),
              'Meme'
                  .text
                  .textStyle(textStyle.blackStyle1
                      .copyWith(fontWeight: FontWeight.w300))
                  .make()
            ]),
            20.heightBox,
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(color.primary),
            )
          ],
          crossAlignment: CrossAxisAlignment.center,
          alignment: MainAxisAlignment.center,
        ).whFull(context);
      }),
    );
  }
}
