class Product {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String description;
  final String brand;
  final String category;
  final String thumbnail;
  final int stock;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.rating,
      required this.description,
      required this.brand,
      required this.category,
      required this.stock,
      required this.thumbnail});
}
