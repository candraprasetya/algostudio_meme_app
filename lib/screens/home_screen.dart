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
      backgroundColor: color.background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Vx.white,
        leading: Image.asset('assets/logo.png').p16(),
        centerTitle: true,
        title: 'AlgoMemes'
            .text
            .textStyle(textStyle.blackStyle1)
            .maxLines(1)
            .make(),
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
                    Get.toNamed('/create', arguments: [
                      state.memes[index]['id'],
                      state.memes[index]['url']
                    ]);
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
