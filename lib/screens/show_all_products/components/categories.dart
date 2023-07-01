import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import 'package:Districap/models/Categories.dart' as MyCategories;

// We need stateful widget for our categories

class Categories extends StatefulWidget {
  final void Function(String category)? onCategorySelected;
  static final List<String> categories = MyCategories.Categories.getAllCategories();
  final String selectedCategory; // Add selectedCategory parameter
  Categories({this.onCategorySelected, required this.selectedCategory});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late int selectedIndex; // Declare selectedIndex as late

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Column(
        children: [
          SizedBox(
            height: 25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Categories.categories.length, // Use the correct item count here
              itemBuilder: (context, index) => buildCategory(index,Categories.categories[index] == widget.selectedCategory),
            ),
          ),
          SizedBox(height: 20),

        ],
      ),
    );
  }

  Widget buildCategory(int index,bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        if (widget.onCategorySelected != null) {
          widget.onCategorySelected!(Categories.categories[index]);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              Categories.categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2), //top padding 5
              height: 2,
              width: 30,
              color: isSelected ? kTextColor : Colors.transparent, // Change color based on isSelected
            )
          ],
        ),
      ),
    );
  }
}