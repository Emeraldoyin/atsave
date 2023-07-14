part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final ThemeData appTheme;
  const ThemeState({required this.appTheme});

  @override
  List<Object> get props => [appTheme];

  @override
  String toString() => 'ThemeState(appTheme: $appTheme)';

}

class ThemeInitial extends ThemeState {
  const ThemeInitial({required super.appTheme});
}

// class ThemeChangedState extends ThemeState {
//   const ThemeChangedState({required AppTheme, required super.themeData});
// }
 