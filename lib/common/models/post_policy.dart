import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_policy.freezed.dart';
part 'post_policy.g.dart';

@immutable
@freezed
class PostPolicy with _$PostPolicy {
  const factory PostPolicy({
    String? policy,
    String? signature,
    String? dir,
    int? expire,
    String? accessId,
    String? host,
  }) = _PostPolicy;

  /// Deserializes the given json into a [PostPolicy].
  factory PostPolicy.fromJson(Map<String, dynamic> json) =>
      _$PostPolicyFromJson(json);
}
