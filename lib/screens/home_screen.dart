part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MemeCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: Image.asset('assets/logo.png').p16(),
        centerTitle: true,
        title: 'AlgoMemes'
            .text
            .textStyle(textStyle.blackStyle1)
            .maxLines(1)
            .make(),
        actions: [
          BlocBuilder<ScreenCubit, ScreenState>(
            builder: (context, state) {
              if (state is ThemeDarkState) {
                return IconButton(
                    icon: Icon(Icons.brightness_3_rounded),
                    onPressed: () => context.read<ScreenCubit>().changeTheme());
              }
              return IconButton(
                  icon: Icon(
                    Icons.wb_sunny,
                    color: color.semanticBlack,
                  ),
                  onPressed: () => context.read<ScreenCubit>().changeTheme());
            },
          )
        ],
      ),
      body: BlocBuilder<MemeCubit, MemeState>(
        builder: (context, state) {
          if (state is GettingMemes) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: GridView.builder(
                itemCount: state.memes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (context.isPortrait) ? 3 : 4),
                itemBuilder: (context, index) {
                  return VxBox(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            state.memes[index]['url'],
                            fit: BoxFit.cover,
                          ))).make().p16().onTap(() {
                    context.read<ScreenCubit>().goToCreateScreen(
                        state.memes[index]['id'], state.memes[index]['url']);
                  });
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(color.primary),
            ),
          );
        },
      ),
    );
  }

  Future refresh() async {
    context.read<MemeCubit>().refresh();
  }
}
