import 'dart:io';

class UploadStoryRequestModel {
  final String description;
  final File photo;
  final num? lat;
  final num? lon;

  UploadStoryRequestModel({
    required this.description,
    required this.photo,
    this.lat,
    this.lon,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'description': description,
      'photo': photo,
      'lat' : lat,
      'lon' :lon
    };

    // if (lat != null && lon != null) {
    //   json['lat'] = lat;
    //   json['lon'] = lon;
    // }

    return json;
  }
}
