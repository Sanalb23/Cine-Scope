import 'package:cine_scope/features/movies/domain/entities/watch_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'watch_provider_model.g.dart';

@JsonSerializable(createToJson: false)
class WatchProviderModel {
  @JsonKey(name: 'provider_id')
  final int id;
  @JsonKey(name: 'provider_name')
  final String name;
  @JsonKey(name: 'logo_path')
  final String? logoPath;

  WatchProviderModel({required this.id, required this.name, this.logoPath});

  factory WatchProviderModel.fromJson(Map<String, dynamic> json) =>
      _$WatchProviderModelFromJson(json);

  WatchProviderModel copyWith({int? id, String? name, String? logoPath}) {
    return WatchProviderModel(
      id: id ?? this.id,
      name: name ?? this.name,
      logoPath: logoPath ?? this.logoPath,
    );
  }

  WatchProvider toDomain() {
    return WatchProvider(id: id, name: name, logoPath: logoPath);
  }
}
