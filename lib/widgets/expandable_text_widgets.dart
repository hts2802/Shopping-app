import 'package:doan/utils/color.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:doan/widgets/Small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ExpandableTextWidgets extends StatefulWidget {
  final String text;
  const ExpandableTextWidgets({Key? key,required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidgets> createState() => _ExpandableTextWidgetsState();
}

class _ExpandableTextWidgetsState extends State<ExpandableTextWidgets> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText=true;

  double textHeight= Dimensions.screenHeight/5.63;
  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf= widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf=widget.text;
      secondHalf= "";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(size: Dimensions.font16,text: firstHalf):Column(
        children: [
          SmallText(height: 1.5,color: Appcolors.paraColor,size: Dimensions.font16,text: hiddenText?(firstHalf+"..."):(firstHalf+secondHalf)),
          InkWell(
            onTap: (){
             setState(() {
               hiddenText=!hiddenText;
             });
            },
            child: Row(
              children: [
                SmallText(size:Dimensions.font16,text: "Show more", color: Appcolors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down: Icons.arrow_drop_up,color: Appcolors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
