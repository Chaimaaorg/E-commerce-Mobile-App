import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import 'package:Districap/screens/show_all_products/components/categories.dart';
import '../../../../../models/Product.dart';
import '../../../controllers/product_controller.dart';
import '../../../providers/product_search_state.dart';
import 'details/details_screen.dart';
import 'itemCard.dart';
import 'package:Districap/models/Categories.dart' as MyCategories;

class Body extends StatefulWidget {
  final ProductSearchState searchPro;
  const Body({super.key, required this.searchPro});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String selectedCategory = "A/V distributor";
  String selectedSubCategory = "";
  int selectedIndex = 0;
  final List<Product> allproductsList = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void resetSubCategory() {
    setState(() {
      selectedSubCategory = "";
    });
  }
  Future<void> fetchProducts() async {
    ProductController productController = ProductController();
    List<Product> products =  await productController.getAllProducts();

    // Apply search filtering if a search query is present
    String searchQuery = widget.searchPro.searchQuery.toLowerCase();
    List<Product> filteredProducts = products;

    if (searchQuery.isNotEmpty) {
      filteredProducts = products.where((product) =>
          product.name.toLowerCase().contains(searchQuery)).toList();
    }
    setState(() {
      selectedCategory = searchQuery.isNotEmpty ? filteredProducts[0]!.category : "A/V distributor";
      selectedSubCategory = searchQuery.isNotEmpty ? filteredProducts[0]!.subCategory : "";
      allproductsList.clear();
      allproductsList.addAll(filteredProducts);
      // selectedIndex = MyCategories.Categories.getAllCategories().indexOf(selectedCategory); // Update the selectedIndex
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "All products",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Categories(
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
              resetSubCategory();
            },
              selectedCategory: selectedCategory// Pass the selectedIndex
          ),
          if (MyCategories.Categories.getSubCategories(selectedCategory).isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Subcategories:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  FilterSubCategories(
                    subCategories: MyCategories.Categories.getSubCategories(selectedCategory),
                    selectedSubCategory: selectedSubCategory,
                    onSubCategorySelected: (subCategory) {
                      setState(() {
                        selectedSubCategory = subCategory;
                      });
                    },
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getFilteredProducts().length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kDefaultPaddin,
                crossAxisSpacing: kDefaultPaddin,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => FutureBuilder(
                future: ProductController.isProductFavorite(
                    getFilteredProducts()[index]!
                        .id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    bool isFavorite = snapshot.data as bool;
                    return ItemCard(
                      isFavorite: isFavorite,
                      product: getFilteredProducts()[index],
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            product: getFilteredProducts()[index],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Product> getFilteredProducts() {
    List<Product> filteredProducts = [];
    for (Product prod in allproductsList) {
      if (prod.category == selectedCategory) {
        if (selectedSubCategory.isEmpty || prod.subCategory == selectedSubCategory) {
          filteredProducts.add(prod);
        }
      }
    }
    return filteredProducts;
  }
}

class FilterSubCategories extends StatelessWidget {
  final List<String> subCategories;
  final String selectedSubCategory;
  final void Function(String subCategory) onSubCategorySelected;

  FilterSubCategories({
    required this.subCategories,
    required this.selectedSubCategory,
    required this.onSubCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: subCategories.map(
            (subCategory) => GestureDetector(
          onTap: () {
            onSubCategorySelected(subCategory);
          },
          child: Chip(
            label: Text(
              subCategory,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            backgroundColor: selectedSubCategory == subCategory ? kPrimaryColor : Color(0xFFfee6ea),
          ),
        ),
      ).toList(),
    );
  }
}
