import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'discriminator.g.dart';

@JsonSerializable()
@immutable
class Discriminator {
  const Discriminator({
    required this.propertyName,
    this.mapping,
  });

  factory Discriminator.fromJson(final Map<String, dynamic> json) => _$DiscriminatorFromJson(json);
  Map<String, dynamic> toJson() => _$DiscriminatorToJson(this);

  final String propertyName;

  final Map<String, String>? mapping;
}
