import 'package:bloc/bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoading()) {
    on<StartAppInitEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      FlutterNativeSplash.remove();
      emit(SplashNavigationReady());
    });
  }
}
