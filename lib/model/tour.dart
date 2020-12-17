class Tour {
  final String id;
  final String name;
  final String info;
  final String image;
  final String price;
  Tour({this.id, this.name, this.info, this.image, this.price});

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
        id: json['id'] ?? DateTime.now().toString(),
        name: json['name'] ?? "",
        info: json['info'] ?? "",
        image: json['image'] ?? "",
        price: json['price'] ?? "");
  }
}
