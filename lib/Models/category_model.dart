class CategoryModel {
  final String categoryName;
  final String imagePath;
  CategoryModel({
    required this.categoryName,
    required this.imagePath,
  });
}

List<CategoryModel> categories = [
  CategoryModel(
    categoryName: "Haircuts",
    imagePath: "assets/Images/cu.png",
  ),
  CategoryModel(
    categoryName: "Dreadlocks",
    imagePath: "assets/Images/dr.png",
  ),
  CategoryModel(
    categoryName: "Hair Color",
    imagePath: "assets/Images/c.png",
  ),
  CategoryModel(
    categoryName: "Pedicure",
    imagePath: "assets/Images/p.png",
  ),
  CategoryModel(
    categoryName: "Manicure",
    imagePath: "assets/Images/m.png",
  ),
];
