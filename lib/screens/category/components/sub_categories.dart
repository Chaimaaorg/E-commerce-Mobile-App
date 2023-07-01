import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import 'package:Districap/screens/category/components/body.dart';
// We need stateful widget for our subCategories

class SubCategories extends StatefulWidget {
  final void Function(String category)? onSubCategorySelected;
  final String selectedSubCategory; // Add selectedCategory parameter
  static List<String> subCategories = [];

  SubCategories(
      {this.onSubCategorySelected, required this.selectedSubCategory});

  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
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
              itemCount: SubCategories.subCategories.length,
              // Use the correct item count here
              itemBuilder: (context, index) => buildCategory(
                  index,
                  SubCategories.subCategories[index] ==
                      widget.selectedSubCategory),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildCategory(int index, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        if (widget.onSubCategorySelected != null) {
          widget.onSubCategorySelected!(SubCategories.subCategories[index]);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              SubCategories.subCategories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2), //top padding 5
              height: 2,
              width: 30,
              color: isSelected
                  ? kTextColor
                  : Colors.transparent, // Change color based on isSelected
            )
          ],
        ),
      ),
    );
  }
}
