import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'screen_state.dart';

class ScreenCubit extends Cubit<ScreenState> {
  ScreenCubit() : super(ScreenInitial());

  void goToCreateScreen(String id, String url) {
    Get.toNamed('/create', arguments: [id, url]);
  }

  void changeTheme() {
    if (state is ThemeDarkState) {
      emit(ThemeLightState());
    } else {
      emit(ThemeDarkState());
    }
  }
}
