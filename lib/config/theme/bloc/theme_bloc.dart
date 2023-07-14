import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(appTheme: AppTheme.lightTheme)) {
    on<ChangeThemeEvent>((event, emit) {
      emit(ThemeInitial(appTheme: event.theme));
      if(event.theme == AppTheme.lightTheme){
       //  emit(state.appTheme(appTheme: event.theme));
      }
     
    });
  }
}
