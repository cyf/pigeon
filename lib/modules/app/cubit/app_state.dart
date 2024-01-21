part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.configs = const <ConfigModel>[],
    this.user,
  });

  final List<ConfigModel> configs;
  final UserModel? user;

  AppState copyWith({
    List<ConfigModel>? configs,
    UserModel? user,
  }) {
    return AppState(
      configs: configs ?? this.configs,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        configs,
        user,
      ];
}
