class DetailStoryResponse {
  bool error;
  String message;
  DetailStory story;

  DetailStoryResponse({
    required this.error,
    required this.message,
    required this.story,
  });

}

class DetailStory {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  num? lat;
  num? lon;

  DetailStory({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });
  factory DetailStory.fromJson(Map<String, dynamic> json) {
    return DetailStory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photoUrl: json['photoUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  @override
  List<Object?> get props => [id];
}
