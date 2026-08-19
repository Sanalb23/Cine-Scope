import 'package:cine_scope/features/movies/domain/entities/watch_provider_region.dart';
import 'package:json_annotation/json_annotation.dart';

part 'watch_provider_region_model.g.dart';

@JsonSerializable()
class WatchProviderRegionModel {
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  @JsonKey(name: 'native_name')
  final String nativeName;

  WatchProviderRegionModel({
    required this.iso31661,
    required this.nativeName,
  });

  factory WatchProviderRegionModel.fromJson(Map<String, dynamic> json) =>
      _$WatchProviderRegionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WatchProviderRegionModelToJson(this);

  WatchProviderRegion toDomain() {
    return WatchProviderRegion(
      iso31661: iso31661,
      nativeName: nativeName,
    );
  }
}
