class Book {
  int? id;
  String? title;
  String? description;
  int? price;

  Book({this.id, this.title, this.description, this.price});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    return data;
  }
}