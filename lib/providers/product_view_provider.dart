import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_model/product_view_model.dart';
import '../repository/product_view_repository.dart';

class ProductViewProvider with ChangeNotifier {

  ProductViewProvider(String id){
    ProductView(id);
  }

  bool _isloading = false;

  bool get isloading => _isloading;

  bool _iserror = false;

  bool get iserror => _iserror;

  final ProductViewRepository productViewRepository = ProductViewRepository();

  ProductViewModel? productViewModel;

  void ProductView(String id) async {
    setIsLoading(true);

    var data=await productViewRepository.productView(id);
    if(data!=null){
      productViewModel=data;
    }else{
      print("Something went wrong");
    }
    setIsLoading(false);
  }

  void setIsLoading(bool status) {
    _isloading = status;
    notifyListeners();
  }

  void setonError(bool status) {
    _iserror = status;
    notifyListeners();
  }
}
