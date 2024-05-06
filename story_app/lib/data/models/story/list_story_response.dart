class ListStoryResponse {
  bool error;
  String message;
  List<ListStory> listStory;

  ListStoryResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory ListStoryResponse.fromJson(Map<String, dynamic> json) {
    return ListStoryResponse(
      error: json['error'],
      message: json['message'],
      listStory: (json['listStory'] as List).map((story) => ListStory.fromJson(story)).toList(),
    );
  }

}

class ListStory {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  num? lat;
  num? lon;

  ListStory({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
     this.lat,
     this.lon,
  });

  factory ListStory.fromJson(Map<String, dynamic> json) {
    return ListStory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photoUrl: json['photoUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      lat: json['lat'] as double?,
      lon: json['lon'] as double?,
    );
  }

}