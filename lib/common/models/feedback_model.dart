import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_model.freezed.dart';
part 'feedback_model.g.dart';

@immutable
@freezed
class FeedbackModel with _$FeedbackModel {
  const factory FeedbackModel({
    String? id,
    String? title,
    String? description,
    List<FeedbackFileModel>? files,
  }) = _FeedbackModel;

  /// Deserializes the given json into a [FeedbackModel].
  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);
}

@immutable
@freezed
class FeedbackFileModel with _$FeedbackFileModel {
  const factory FeedbackFileModel({
    String? id,
    String? url,
    String? type,
    int? size,
    String? text,
  }) = _FeedbackFileModel;

  /// Deserializes the given json into a [FeedbackFileModel].
  factory FeedbackFileModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFileModelFromJson(json);
}
