import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvmbasic/repository/home_repository.dart';

import '../data_model/product_list_model.dart';
import '../data_model/product_view_model.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    productsList();
  }

  bool _isloading = false;

  bool get isloading => _isloading;

  bool _iserror = false;

  bool get iserror => _iserror;

  final HomeRepository homeRepository = HomeRepository();

  List<ProductsList>? productList = [];

  int value = 0;

  void productsList() async {
    setIsLoading(true);
    var data = await homeRepository.productList({});

    if (data != null) {
      productList?.addAll(data);
    } else {
      if (kDebugMode) {
        print("Something went wrong");
      }
    }
    setIsLoading(false);
  }

  void increment() {
    value++;
    notifyListeners();
  }

  void decrement() {
   if(value>0){
     value--;
   }
    notifyListeners();
  }

  void starFunction(){
    int i,j;
    for(i=1;i<=5;i++){
      for(j=1;j<=i;j++){
        print(j);
      }
      print("\n");
    }
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
