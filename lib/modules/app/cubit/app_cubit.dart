// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:pigeon/common/models/models.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void addConfigs(List<ConfigModel> configs) =>
      emit(state.copyWith(configs: configs));

  void addUser(UserModel? user) => emit(state.copyWith(user: user));
}
