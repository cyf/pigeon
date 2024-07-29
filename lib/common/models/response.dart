// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'response.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class HpResponse<T> extends Equatable {

  const HpResponse({
    this.msg,
    this.code,
    this.timestamp,
    this.data,
  });

  // Interesting bits here → ----------------------------------- ↓ ↓
  factory HpResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$HpResponseFromJson<T>(json, fromJsonT);

  final String? msg;
  final int? code;
  final int? timestamp;
  final T? data;

  // And here → ------------- ↓ ↓
  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$HpResponseToJson<T>(this, toJsonT);

  @override
  List<Object?> get props => [msg, code, data];
}
