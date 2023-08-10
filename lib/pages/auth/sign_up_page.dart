import 'package:doan/base/custom_loader.dart';
import 'package:doan/base/show_custom_snackbar.dart';
import 'package:doan/controllers/auth_controller.dart';
import 'package:doan/models/signup_body_model.dart';
import 'package:doan/pages/home/main_food_page.dart';
import 'package:doan/routes/route_helper.dart';
import 'package:doan/widgets/Big_text.dart';
import 'package:doan/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    var signUpImages = [
      "i.png",
      "f.png",
      "g.png",
        ];
    void _registration(AuthController authController){

      String name= nameController.text.trim();
      String phone= phoneController.text.trim();
      String email= emailController.text.trim();
      String password= passwordController.text.trim();

      if(name.isEmpty){
       showCustomSnackBar("Type in your name !", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number !", title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address !", title: "Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address !", title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password !", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password can't be less than six characters !", title: "Password");
      }else{
        showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            password: password,
            email: email,
            phone: phone,
            name: name);
            authController.registration(signUpBody).then((status){
              if(status.isSuccess){
              print("Success registration");
              Get.offNamed(RouteHelper.getInitial());
              }else{
                showCustomSnackBar(status.message);
              }
        });

        print(signUpBody.toString());
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder:(_authController){
        return !_authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/logo part 1.jpg"
                    ),
                  ),
                ),
              ),
              //email
              AppTextFeild(
                  icon: Icons.email,
                  hintText: "Email",
                  textController: emailController),
              SizedBox(height: Dimensions.height20,),
              //passwork
              AppTextFeild(
                  icon: Icons.password_sharp,isObscure: true,
                  hintText: "Passwork",
                  textController: passwordController),
              SizedBox(height: Dimensions.height20,),
              //name
              AppTextFeild(
                  icon: Icons.person,
                  hintText: "Name",
                  textController: nameController),
              SizedBox(height: Dimensions.height20,),
              //phone
              AppTextFeild(
                  icon: Icons.phone,
                  hintText: "Phone",
                  textController: phoneController),
              SizedBox(height: Dimensions.height20+Dimensions.height20,),
              //sign up button
              GestureDetector(
                onTap: (){
                  _registration(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(text: "Sign Up",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              //tag line
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Have an accout already ?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                text: TextSpan(
                  text: "Sign up using one of the following methods",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font16,
                  ),
                ),
              ),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/image/"+signUpImages[index]
                    ),
                  ),
                )),
              )
            ],
          ),
        ):const CustomLoader();
      })
    );


  }
}
