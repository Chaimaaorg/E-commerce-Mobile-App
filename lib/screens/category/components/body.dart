import 'package:Districap/screens/category/components/sub_categories.dart';
import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../../../../../controllers/product_controller.dart';
import '../../../../../models/Product.dart';
import '../../../../../models/Categories.dart' as MyCategories;
import '../../../providers/product_search_state.dart';
import 'details/details_screen.dart';
import 'itemCard.dart';

class Body extends StatefulWidget {
  final String category;
  final ProductSearchState searchPro;

  Body({required this.category, super.key, required this.searchPro});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String selectedSubCategory = ""; // Default selected category
  bool isLoading = false;
  final List<Product?> products = [];
  int selectedIndex = 0; // Initialize selectedIndex to 0

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    ProductController productController = ProductController();
    List<Product?> productss =
        await productController.getProductsByCategory(widget.category);

    String searchQuery = widget.searchPro.searchQuery.toLowerCase();
    List<Product?> filteredProducts = productss;

    if (searchQuery.isNotEmpty) {
      filteredProducts = productss
          .where((product) =>
              product?.name.toLowerCase().contains(searchQuery) ?? false)
          .toList();
    }

    setState(() {
      selectedSubCategory = searchQuery.isNotEmpty
          ? filteredProducts[0]!.subCategory
          : MyCategories.Categories.getSubCategories(widget.category)[0];
      SubCategories.subCategories =
          MyCategories.Categories.getSubCategories(widget.category);
      products.clear();
      products.addAll(filteredProducts);
      isLoading =
          false; // You might need to adjust this based on your use case.
      selectedIndex = MyCategories.Categories.getSubCategories(widget.category)
          .indexOf(selectedSubCategory); // Update the selectedIndex
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
              widget.category,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SubCategories(
            onSubCategorySelected: (category) {
              setState(() {
                selectedSubCategory = category;
              });
            },
            selectedSubCategory: selectedSubCategory,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: getSubCategoryProduct(
                            selectedSubCategory, widget.searchPro.searchQuery)
                        .length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kDefaultPaddin,
                      crossAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => FutureBuilder(
                      future: ProductController.isProductFavorite(
                          getSubCategoryProduct(selectedSubCategory,
                                  widget.searchPro.searchQuery)[index]!
                              .id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          bool isFavorite = snapshot.data as bool;
                          return ItemCard(
                            isFavorite: isFavorite,
                            product: getSubCategoryProduct(selectedSubCategory,
                                widget.searchPro.searchQuery)[index],
                            press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  product: getSubCategoryProduct(
                                      selectedSubCategory,
                                      widget.searchPro.searchQuery)[index],
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

  List<Product?> getSubCategoryProduct(String subCategory, String searchQuery) {
    List<Product?> listSubCategory = [];
    Product? prod;
    for (prod in products) {
      if (prod!.subCategory == subCategory &&
          (searchQuery.isEmpty ||
              prod.name.toLowerCase().contains(searchQuery.toLowerCase()))) {
        listSubCategory.add(prod);
      }
    }
    return listSubCategory;
  }
}
