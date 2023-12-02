import 'package:freezed_annotation/freezed_annotation.dart';

part 'carousel_model.freezed.dart';
part 'carousel_model.g.dart';

@immutable
@freezed
class CarouselModel with _$CarouselModel {
  const factory CarouselModel({
    String? id,
    @Default('')
    String image,
    @Default(0)
    int order,
    String? text,
    String? color,
    String? href,
  }) = _CarouselModel;

  /// Deserializes the given json into a [CarouselModel].
  factory CarouselModel.fromJson(Map<String, dynamic> json) =>
      _$CarouselModelFromJson(json);
}
