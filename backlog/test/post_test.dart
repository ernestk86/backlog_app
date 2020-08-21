import 'package:flutter_test/flutter_test.dart';
import '../lib/src/models/post.dart';

void main() {
  test('Post creation Test', () {
    // Create instance of Post
    Post post = Post(
      date: DateTime.parse('2020-01-01'),
      quantity: 4,
      latitude: 66.69,
      longitude: 55.40,
      imageURL: 'TESTING',
    );

    // Verify correct values for new Post
    expect(post.date, isNotNull);
    expect(post.quantity, 4);
    expect(post.imageURL, 'TESTING');
  });

  test('Post toString() Test', () {
    //Assign variables
    String imageURL = 'TESTINGTHISOUT';
    int quantity = 77;
    double latitude = 50.32;
    double longitude = 99.12;
    var date = DateTime.parse('2020-04-03');

    // Create instance of Post
    Post post = Post(
      date: date,
      quantity: quantity,
      latitude: latitude,
      longitude: longitude,
      imageURL: imageURL,
    );

    // Verify that function works
    expect(
      post.toString(), 
      'Post{imageURL: $imageURL, quantity: $quantity, latitude: $latitude, longitude: $longitude, date: $date}'
    );
  });
}
