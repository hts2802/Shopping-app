import 'package:doan/base/custom_loader.dart';
import 'package:doan/controllers/auth_controller.dart';
import 'package:doan/controllers/cart_controller.dart';
import 'package:doan/controllers/user_controller.dart';
import 'package:doan/pages/home/main_food_page.dart';
import 'package:doan/routes/route_helper.dart';
import 'package:doan/utils/dimensions.dart';
import 'package:doan/widgets/Big_text.dart';
import 'package:doan/widgets/account_widget.dart';
import 'package:doan/widgets/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn= Get.find<AuthController>().userLoggedIn();
      if(_userLoggedIn){
        Get.find<UserController>().getUserInfo();
      }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,

        title: Center(
          child: BigText(
                     text: "Profile",size: 24, color: Colors.white,
                   ),
        ),

      ),

      body: GetBuilder<UserController>(builder: (userController){
      return _userLoggedIn?(userController.isLoading?Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            // profile icon
            AppIcon(icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.iconSize25*3,
              size: Dimensions.height15*10,),
            SizedBox(height: Dimensions.height30,),


            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //name
                    AccountWidget(
                        appIcon: AppIcon(icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: userController.userModel.name,)),
                    SizedBox(height: Dimensions.height20,),
                    //phone
                    AccountWidget(
                        appIcon: AppIcon(icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: userController.userModel.phone,)),
                    SizedBox(height: Dimensions.height20,),
                    //email
                    AccountWidget(
                        appIcon: AppIcon(icon: Icons.email,
                          backgroundColor: Colors.green,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: userController.userModel.email,)),
                    SizedBox(height: Dimensions.height20,),
                    //address
                    AccountWidget(
                        appIcon: AppIcon(icon: Icons.location_on,
                          backgroundColor: Colors.brown,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "566/21A Nguyen Thai Son",)),
                    SizedBox(height: Dimensions.height20,),
                    //message
                    AccountWidget(
                        appIcon: AppIcon(icon: Icons.message,
                          backgroundColor: Colors.redAccent,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "Messages",)),
                    SizedBox(height: Dimensions.height20,),
                    //logout
                    GestureDetector(
                      onTap: (){
                        if(Get.find<AuthController>().userLoggedIn()){
                          Get.find<AuthController>().clearSharedData();
                          Get.find<CartController>().clear();
                          Get.find<CartController>().clearCartHistory();
                          Get.offNamed(RouteHelper.getSpashPage());
                        }

                      },
                      child: AccountWidget(
                          appIcon: AppIcon(icon: Icons.logout,
                            backgroundColor: Colors.grey,
                            iconColor: Colors.black54,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "Logout",)),
                    ),
                    SizedBox(height: Dimensions.height20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ):
      CustomLoader()):
      Container(

          child: Center(child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Container(
            width:  double.maxFinite,
            height: Dimensions.height20*8,
            margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                image: DecorationImage(

                    image: AssetImage(
                        "assets/image/signintocontinue.png"
                    )
                )
            ),
          ),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getSignInPage());
                  Transition.fade;
                },
                child: Container(

                  width:  Dimensions.height20*7,
                  height: Dimensions.height20*3,
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20,top: Dimensions.height20),
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),

                  ),
                  child: Center(child: BigText(text: "Sign in",color: Colors.white,size: Dimensions.font26,)),
                ),
              ),


        ],
      )));

      })
    );
  }
}
