class DetailStoryResponse {
  bool? error;
  String? message;
  DetailStory? story;

  DetailStoryResponse({
    this.error,
    this.message,
    this.story,
  });

  factory DetailStoryResponse.fromJson(Map<String, dynamic> json) {
    return DetailStoryResponse(
      error: json['error'] ?? true,
      message: json['message'] ?? '',
      story: DetailStory.fromJson(json['story']),
    );
  }
}

class DetailStory {
  String? id;
  String? name;
  String? description;
  String? photoUrl;
  DateTime? createdAt;
  num? lat;
  num? lon;

  DetailStory({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
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
