import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_event.dart';

part 'splash_state.dart';

part 'splash_bloc.freezed.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const _Initial()) {
    on<SplashEvent>((event, emit) async {
      if (event is _Started) {
        await Future.delayed(const Duration(seconds: 3));

        emit(const _Success());
      }
    });
  }
}
