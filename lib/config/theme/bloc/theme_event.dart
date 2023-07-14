part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  final ThemeData theme;

  const ChangeThemeEvent({
    required this.theme,
  });

  @override
  List<Object> get props => [theme];
}
