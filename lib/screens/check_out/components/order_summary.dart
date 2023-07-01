import 'package:flutter/material.dart';

import '../../../constants.dart';

class OrderSummary extends StatelessWidget {
  final double total;

  const OrderSummary({
    Key? key,
    this.total = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SUBTOTAL', style: Theme.of(context).textTheme.bodyMedium),
              Text('${total}dh', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DELIVERY FEE',
                  style: Theme.of(context).textTheme.bodyMedium),
              Text('53dh', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5.0),
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: bluePanel,
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                offset: Offset(1, 1),
                spreadRadius: 5.5,
                blurRadius: 2.0,
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'TOTAL',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  '${total! + 53.0} dh',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
