part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.configs,
    this.user,
  });

  final List<ConfigModel>? configs;
  final UserModel? user;

  AppState copyWith({
    List<ConfigModel>? configs,
    UserModel? user,
  }) {
    return AppState(
      configs: configs,
      user: user,
    );
  }

  @override
  List<Object?> get props => [
        configs,
        user,
      ];
}
