class Post {
  final String imageURL;
  final int quantity;
  final double latitude;
  final double longitude;
  var date;

  Post({this.imageURL, this.quantity, this.latitude, this.longitude, this.date});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      imageURL: json['imageURL'],
      quantity: int.parse(json['quantity']),
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      date: json['date'],
    );
  }

  @override
  String toString() {
    return 'Post{imageURL: $imageURL, quantity: $quantity, latitude: $latitude, longitude: $longitude, date: $date}';
  }
}