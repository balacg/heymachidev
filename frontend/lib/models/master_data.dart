// lib/models/master_data.dart

class Tax {
  final int id;
  final String name;
  final double rate;

  Tax({required this.id, required this.name, required this.rate});
}

class Category {
  final int id;
  final String name;
  final Tax gst;

  Category({required this.id, required this.name, required this.gst});
}

class Subcategory {
  final int id;
  final String name;
  final Category category;
  final Tax gst;

  Subcategory({required this.id, required this.name, required this.category, required this.gst});
}

class Product {
  final int id;
  final String name;
  final Category category;
  final Subcategory subcategory;
  final Tax gst;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.gst,
    required this.price,
  });
}

// Global shared lists for master data

List<Tax> taxList = [
  Tax(id: 1, name: 'GST', rate: 18.0),
  Tax(id: 2, name: 'VAT', rate: 5.0),
];

List<Category> categoryList = [
  Category(id: 1, name: 'Electronics', gst: taxList[0]),
  Category(id: 2, name: 'Groceries', gst: taxList[1]),
];

List<Subcategory> subcategoryList = [
  Subcategory(id: 1, name: 'Mobile Phones', category: categoryList[0], gst: taxList[0]),
  Subcategory(id: 2, name: 'Fruits', category: categoryList[1], gst: taxList[1]),
];

List<Product> productList = [
  Product(
    id: 1,
    name: 'iPhone 14',
    category: categoryList[0],
    subcategory: subcategoryList[0],
    gst: taxList[0],
    price: 70000.0,
  ),
  Product(
    id: 2,
    name: 'Banana',
    category: categoryList[1],
    subcategory: subcategoryList[1],
    gst: taxList[1],
    price: 30.0,
  ),
  // Add more sample products as needed
];
