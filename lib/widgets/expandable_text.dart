import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:food_odering_app/widgets/texts.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimentions.screenHeight/5.63;

  @override
  void initState() {
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ?
      SmallText(text: firstHalf)
          :
      Column(
        children: [
          SmallText(
              text: hiddenText
                  ?
              ("$firstHalf...")
                  :
              (firstHalf+secondHalf),
            size: Dimentions.font16,
            color: AppColors.paraColor,

          ),
          InkWell(
            child: Row(
              children: [
                SmallText(text: "Show more",color: AppColors.paraColor,size: Dimentions.font16,),
                Icon(hiddenText ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,color: AppColors.mainColor,)
              ],
            ),
            onTap: (){
              setState(() {
                hiddenText =! hiddenText;
              });
            },
          ),
        ],
      ),
    );
  }
}
