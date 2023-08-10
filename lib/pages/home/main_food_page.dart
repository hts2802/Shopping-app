import 'package:doan/utils/dimensions.dart';
import 'package:doan/widgets/Big_text.dart';
import 'package:doan/widgets/Small_text.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void>_loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: Column(
      children: [
        //showing the header
        Container(

          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "VietNam", color: AppColors.mainColor),
                    Row(
                      children: [
                        SmallText(text: "TP.HoChiMinh", color: Colors.black54),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: Icon(Icons.search, color: Colors.white,size: Dimensions.iconSize24,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        //showing the body
        Expanded(child: SingleChildScrollView(

          child: FoodPageBody(),

        ))
      ],
    ), onRefresh: _loadResource);
  }
}

class AppColors {

  static final Color textColor = const Color(0xFFccc7c5);
  static final Color mainColor= const Color(0xFF89dad0);
  static final Color IconColor1= const Color(0xFFffd28d);
  static final Color IconColor2= const Color(0xFFfcab88);
  static final Color paraColor= const Color(0xFF8f837f);
  static final Color ButtonBackgroundColor= const Color(0xFFf7f6f4);
  static final Color signColor= const Color(0xFFa9a29f);
  static final Color titleColor= const Color(0xFF5c524f);
  static final Color mainBlackColor= const Color(0xFF332d2d);
  static final Color yellowColor= const Color(0xFFffd379);
}
