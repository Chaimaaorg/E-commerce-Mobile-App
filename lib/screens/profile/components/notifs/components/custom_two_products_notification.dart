import 'package:Districap/components/size_config.dart';
import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../../../../../widgets/settings_widgets/custom_notification_image.dart';

class CustomTwoProductsNotification extends StatelessWidget {
  const CustomTwoProductsNotification({
    this.imageProduct1 ="assets/images/screen1.png",
    this.imageProduct2 ="assets/images/camera1.png",
    this.product1 = "Smart TV",
    this.product2 = "Video Camera",
    Key? key,
  }) : super(key: key);

  final String product1,product2;
  final String imageProduct1,imageProduct2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(80),
          width: getProportionateScreenWidth(80),
          child:  Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: CustomNotificationImage(image: imageProduct1!,active: false,),
              ),
              Positioned(
                bottom: 10,
                child: CustomNotificationImage(image: imageProduct2!,active: false,),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 0 ,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                maxLines: 2,
                text: TextSpan(
                      text:product1!,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: mainText, fontSize: 18, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                  text:"  and \n",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: SecondaryText),
                      ),
                      TextSpan(text: product2!)
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("New promotion!!",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: SecondaryText))
            ],
          ),
        ),
        Image.asset(
          "assets/images/Cover.png",
          height: 64,
          width: 64,
        ),
      ],
    );
  }
}
