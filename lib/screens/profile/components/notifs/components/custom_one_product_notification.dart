import 'package:Districap/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../widgets/settings_widgets/custom_notification_button.dart';
import '../../../../../widgets/settings_widgets/custom_notification_image.dart';

class CustomOneProductNotification extends StatefulWidget {
  const CustomOneProductNotification({
    this.type = "Promotion",
    this.imageProduct ="assets/images/wireless headset.png",
    this.discount = "40%",
    Key? key,
  }) : super(key: key);

  final String type;
  final String discount;
  final String imageProduct;

  @override
  State<CustomOneProductNotification> createState() =>
      _CustomOneProductNotificationState();
}


class _CustomOneProductNotificationState extends State<CustomOneProductNotification> {
  bool follow = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNotificationImage(image: widget.imageProduct,active: true,),
        const SizedBox(width: 15),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.type}  ${widget.discount}',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: mainText, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "New promotion!",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: SecondaryText),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                left: follow == false
                    ? getProportionateScreenWidth(30)
                    : getProportionateScreenWidth(30)),
            child: CustomNotificationButton(
              height: getProportionateScreenHeight(40),
              color: follow == false ? kPrimaryColor : form,
              textColor: follow == false ? Colors.white : mainText,
              onTap: () {
                setState(() {
                  follow = !follow;
                });
              },
              text: "View",
            ),
          ),
        ),
      ],
    );
  }
}

