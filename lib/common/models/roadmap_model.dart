import 'package:freezed_annotation/freezed_annotation.dart';

part 'roadmap_model.freezed.dart';
part 'roadmap_model.g.dart';

@immutable
@freezed
class RoadmapModel with _$RoadmapModel {
  const factory RoadmapModel({
    String? title,
    String? description,
    DateTime? from,
    DateTime? to,
    String? background,
    @Default(false)
    bool isAllDay,
    List<Tag>? tags,
    // TODO(kjxbyz): 添加执行人, 任务状态
  }) = _RoadmapModel;

  /// Deserializes the given json into a [RoadmapModel].
  factory RoadmapModel.fromJson(Map<String, dynamic> json) =>
      _$RoadmapModelFromJson(json);
}

@immutable
@freezed
class Tag with _$Tag {
  const factory Tag({
    String? title,
    String? color,
  }) = _Tag;

  /// Deserializes the given json into a [Tag].
  factory Tag.fromJson(Map<String, dynamic> json) =>
      _$TagFromJson(json);
}
