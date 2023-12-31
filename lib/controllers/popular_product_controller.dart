import 'package:doan/data/repository/popular_product_repo.dart';
import 'package:doan/pages/home/main_food_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  bool _isLoaded = false;
  bool get isLoaded=>_isLoaded;
  int get quantity=>_quantity;
  int _quantity=0;
  int _inCartItems=0;
  int get inCartItems=> _inCartItems+_quantity;

  List<dynamic> _popularProductList=[];
  List<dynamic> get PopularProductList => _popularProductList;
  late CartController _cart;
  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){

      //print("got products");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);

      _isLoaded=true;
      update();
    }else{

    }
  }
  void setQuantity(bool isIncrement){
    if(isIncrement){
     _quantity=checkQuantity(_quantity+1);
    }else{
     _quantity=checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Item count", "You can't reduce more !",
         backgroundColor: AppColors.mainColor,
         colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return int.parse("0");
    }else if((_inCartItems+quantity)>20){
      Get.snackbar("Item count", "You can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,);
      return int.parse("20");
    }else{
      return quantity;
    }
  }
  void initProduct(ProductModel product, CartController cart){
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    var exist=false;
    exist = _cart.existInCart(product);
    //print("exist or not"+exist.toString());
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
    //print("the quantity in the cart is "+_inCartItems.toString());

  }
  void addItem(ProductModel product ){


      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCartItems=_cart.getQuantity(product);

      _cart.items.forEach((key, value) {
        //print("The id is "+value.id.toString()+" The quantity is "+value.quantity.toString());
      });
    update();
    }
    int get totalItems{
    return _cart.totalItems;
    }
    List<CartModel> get getItems{
    return _cart.getItems;
    }
  }
