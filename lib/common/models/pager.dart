import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'pager.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class Pager<T> extends Equatable {

  const Pager({
    this.page,
    this.pageSize,
    this.pageInfo,
    this.items,
  });

  // Interesting bits here → ----------------------------------- ↓ ↓
  factory Pager.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PagerFromJson<T>(json, fromJsonT);

  final int? page;
  final int? pageSize;
  final PageInfo? pageInfo;
  final T? items;

  // And here → ------------- ↓ ↓
  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$PagerToJson<T>(this, toJsonT);

  @override
  List<Object?> get props => [page, pageSize, pageInfo, items];
}

@immutable
@JsonSerializable()
class PageInfo extends Equatable {

  const PageInfo({
    this.total,
    this.pages,
  });

  final int? total;
  final int? pages;

  /// Deserializes the given [Map<String, dynamic>] into a [PageInfo].
  static PageInfo fromJson(Map<String, dynamic> json) => _$PageInfoFromJson(json);

  /// Converts this [PageInfo] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$PageInfoToJson(this);

  @override
  List<Object?> get props => [total, pages];
}
