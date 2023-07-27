class Rating {
  final num rate;
  final num count;

  const Rating({this.rate = 0, this.count = 0});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"],
    count: json["count"],
  );
}