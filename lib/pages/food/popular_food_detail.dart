import 'package:doan/controllers/cart_controller.dart';
import 'package:doan/controllers/popular_product_controller.dart';
import 'package:doan/pages/cart/cart_page.dart';
import 'package:doan/pages/home/food_page_body.dart';
import 'package:doan/routes/route_helper.dart';
import 'package:doan/utils/app_constants.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:doan/widgets/app_column.dart';
import 'package:doan/widgets/expandable_text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import '../../widgets/Big_text.dart';
import '../../widgets/Small_text.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../home/main_food_page.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductController>().PopularProductList[pageId];


    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.PopularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                    )
                  )
                ),
              )
          ),
          //icon widgets
          Positioned(
            top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                 onTap:(){
                   if(page=="cartpage"){
                    Get.toNamed(RouteHelper.getCartPage());
                   }else{
                     Get.toNamed(RouteHelper.getInitial());
                   }
                 },
                  child:
                  AppIcon(icon: Icons.arrow_back_ios)
              ),


              GetBuilder<PopularProductController>(builder: (controller){
                 return GestureDetector(
                   onTap: (){
                     if(controller.totalItems>=1)
                     Get.toNamed(RouteHelper.getCartPage());
                   },
                   child: Stack(
                     children: [

                            AppIcon(icon: Icons.shopping_cart_outlined,),
                       controller.totalItems>=1?
                       Positioned(
                         right:0, top:0,
                         child: AppIcon(icon: Icons.circle, size: 20,
                           iconColor: Colors.transparent,
                           backgroundColor: AppColors.mainColor,),
                       ):
                         Container(),
                       Get.find<PopularProductController>().totalItems>=1?
                       Positioned(
                         right:3, top:3,
                         child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                         size:12,color: Colors.white,
                         ),
                       ):
                       Container(),
                     ],
                   ),
                 );
              })



            ],
          )),
          //introduction of food
          Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: Dimensions.PopularFoodImgSize-20,
              child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidgets(text: product.description!)))
                  ],
                ),
          ))
          //expandable text widgets

        ],
      ),
      ///container button
        bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.setQuantity(false);
                  },
                  child:  AppIcon(
                      iconSize: Dimensions.iconSize24,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      icon: Icons.remove),
                ),
                BigText(text: "${controller.inCartItems} ",color: AppColors.mainBlackColor,size: Dimensions.font26,),
                GestureDetector(
                  onTap: (){
                    controller.setQuantity(true);
                  },
                  child:  AppIcon(
                      iconSize: Dimensions.iconSize24,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      icon: Icons.add),
                ),
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ///price
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: BigText(text: "\$ ${product.price!}",color: Colors.black,),

                ),
                ///button add to cart
                GestureDetector(
                  onTap: (){
                    controller.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                    child: BigText(text: "add to cart",color: Colors.white,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.deepOrange,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      );
    }));
  }
}
