// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'yt_response.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class YTResponse<T> extends Equatable {
  const YTResponse({
    this.kind,
    this.etag,
    this.prevPageToken,
    this.nextPageToken,
    this.regionCode,
    this.pageInfo,
    this.items,
  });

  // Interesting bits here → ----------------------------------- ↓ ↓
  factory YTResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$YTResponseFromJson<T>(json, fromJsonT);

  final String? kind;
  final String? etag;
  final String? prevPageToken;
  final String? nextPageToken;
  final String? regionCode;
  final YTPageInfo? pageInfo;
  final T? items;

  // And here → ------------- ↓ ↓
  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$YTResponseToJson<T>(this, toJsonT);

  @override
  List<Object?> get props => [
        kind,
        etag,
        prevPageToken,
        nextPageToken,
        regionCode,
        pageInfo,
        items,
      ];
}

@immutable
@JsonSerializable()
class YTPageInfo extends Equatable {
  const YTPageInfo({
    this.totalResults,
    this.resultsPerPage,
  });

  factory YTPageInfo.fromJson(Map<String, dynamic> json) =>
      _$YTPageInfoFromJson(json);

  final int? totalResults;
  final int? resultsPerPage;

  // And here → ------------- ↓ ↓
  Map<String, dynamic> toJson() => _$YTPageInfoToJson(this);

  @override
  List<Object?> get props => [
        totalResults,
        resultsPerPage,
      ];
}
