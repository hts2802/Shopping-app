import 'package:doan/utils/dimensions.dart';
import 'package:doan/widgets/Small_text.dart';
import 'package:flutter/cupertino.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color Iconcolor;
  const IconAndTextWidget({Key? key,
    required this.icon,
    required this.text,

    required this.Iconcolor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: Iconcolor,size: Dimensions.iconSize24,),
        SizedBox(width: 5,),
        SmallText(text: text,)
      ],
    );
  }
}
