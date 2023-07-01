import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../models/Promotion.dart';
import '../../../../../providers/promotion_provider.dart';
import 'custom_one_product_notification.dart';
import 'custom_two_products_notification.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Promotion> promotions = [];

  @override
  void initState() {
    super.initState();
    fetchPromotions(); // Call the fetchPromotions method in initState
  }

  Future<void> fetchPromotions() async {
    promotions = await context.read<PromotionProvider>().getPromotions();
    setState(() {}); // Update the state after fetching promotions
  }


  Widget buildCustomNotification({
    required Promotion promotion,
    required bool isTwoProducts,
    required int index,
  }) {
    if (isTwoProducts && index == 0) {
      return CustomTwoProductsNotification(
        product1: promotion.productName!,
        product2: promotions[1].productName!,
        imageProduct1: promotion.productImage!,
        imageProduct2: promotions[1].productImage!,
      );
    } else {
      return CustomOneProductNotification(
        type: promotion.type!,
        discount: promotion.discount!,
        imageProduct: promotion.productImage!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    List<Promotion> nowPromotions = [];
    List<Promotion> todayPromotions = [];
    List<Promotion> oldPromotions = [];

    for (var promotion in promotions) {
      if (promotion.startDate!.isAfter(now)) {
        nowPromotions.add(promotion);
      } else if (promotion.endDate!.isBefore(now)) {
        oldPromotions.add(promotion);
      } else {
        todayPromotions.add(promotion);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (nowPromotions.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Now",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: nowPromotions.length,
                      itemBuilder: (context, index) {
                        return buildCustomNotification(
                          promotion: nowPromotions[index],
                          isTwoProducts: oldPromotions.length >= 2,
                          index: index,
                        );
                      },
                    ),
                  ],
                ),
              if (todayPromotions.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Today",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: todayPromotions.length,
                      itemBuilder: (context, index) {
                        return buildCustomNotification(
                          promotion: todayPromotions[index],
                          isTwoProducts: todayPromotions.length >= 2,
                          index: index,
                        );
                      },
                    ),
                  ],
                ),
              if (oldPromotions.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Old",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: oldPromotions.length,
                      itemBuilder: (context, index) {
                        return buildCustomNotification(
                          promotion: oldPromotions[index],
                          isTwoProducts: oldPromotions.length >= 2,
                          index: index,
                        );
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

