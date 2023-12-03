import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_model.freezed.dart';
part 'file_model.g.dart';

@immutable
@freezed
class FileModel with _$FileModel {
  const factory FileModel({
    String? url,
    String? pathname,
    String? contentType,
    int? fileSize,
  }) = _FileModel;

  /// Deserializes the given json into a [FileModel].
  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);
}
