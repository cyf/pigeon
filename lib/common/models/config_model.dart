// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';

@immutable
@freezed
class ConfigModel with _$ConfigModel {
  const factory ConfigModel({
    String? id,
    String? key,
    String? value,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'start_date') DateTime? startDate,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'end_date') DateTime? endDate,
  }) = _ConfigModel;

  /// Deserializes the given json into a [ConfigModel].
  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);
}
