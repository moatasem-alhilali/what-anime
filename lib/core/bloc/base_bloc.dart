import 'dart:async';
import 'package:anime_finder/core/helper/cash/cash_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:anime_finder/core/utils/constant.dart';
part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(BaseState()) {
    //change theme
    on<ChangeLangEvent>(changeLang);
  }

  FutureOr<void> changeLang(event, emit) async {
    isArabic = event.isArabic;
    await CashHelper.setData(key: 'lan', value: event.isArabic);
    emit(BaseState());
  }
}
