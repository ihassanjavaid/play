class Video {
  final String? id;
  final String? title;
  final String? thumbnailUrl;
  final String? channelTitle;
  bool? liked;

  Video({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
    this.liked = false,
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
      liked: false
    );
  }

  factory Video.fromFirebase(Map<String, dynamic> doc) {
    return Video(
        id: doc['id'],
        title: doc['title'],
        thumbnailUrl: doc['thumbnailUrl'],
        channelTitle: doc['channelTitle'],
        liked: true
    );
  }
}