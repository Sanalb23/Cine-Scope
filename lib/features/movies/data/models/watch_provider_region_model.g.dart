// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_provider_region_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchProviderRegionModel _$WatchProviderRegionModelFromJson(
  Map<String, dynamic> json,
) => WatchProviderRegionModel(
  iso31661: json['iso_3166_1'] as String,
  nativeName: json['native_name'] as String,
);

Map<String, dynamic> _$WatchProviderRegionModelToJson(
  WatchProviderRegionModel instance,
) => <String, dynamic>{
  'iso_3166_1': instance.iso31661,
  'native_name': instance.nativeName,
};
