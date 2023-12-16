part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.configs = const <ConfigModel>[],
  });

  final List<ConfigModel> configs;

  AppState copyWith({
    List<ConfigModel>? configs,
  }) {
    return AppState(
      configs: configs ?? this.configs,
    );
  }

  @override
  List<Object?> get props => [
        configs,
      ];
}
