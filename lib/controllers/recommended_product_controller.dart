import 'package:doan/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import '../data/repository/recommended_product_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _RecommendedProductList=[];
  List<dynamic> get recommendedProductList => _RecommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded=>_isLoaded;


  Future<void> getRecommendedProductList() async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200){

      //print("got products reccommended");
      _RecommendedProductList=[];
      _RecommendedProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded=true;
      update();
    }else{
      //print("could not get products reccommended");
    }
  }
}