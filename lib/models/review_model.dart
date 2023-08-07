class ReviewModel {
  // String id;
  String userID;

  // String productID;
  num rating;
  String comment;
  int timestamp;

  ReviewModel({
    // required this.id,
    required this.userID,
    required this.rating,
    required this.comment,
    required this.timestamp,
    // required this.productID,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      // id: json['id'],
      userID: json['userID'],
      rating: json['rating'],
      comment: json['comment'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() => {"userID": userID, 'rating': rating, 'comment': comment, 'timestamp': timestamp};
}
