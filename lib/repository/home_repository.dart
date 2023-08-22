import 'package:mvvmbasic/utils/api_end_points.dart';

import '../data_model/product_list_model.dart';
import '../data_model/product_view_model.dart';
import '../data_services/api_helper.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';

class HomeRepository {
  final ApiHelper _apiHelper = ApiHelper();

  Future<dynamic> productList(Map<String, String>? params) async {
    var data = await errorHandler(
      _apiHelper.multiMethod(
        BASEURL,
        PRODUCTSLIST,
        methodtype: ApiTypeEnum.GET,
      ),true,true);
    if (data == null) return null;

    print(data);
    ///data load error
    var productListModel = modelErrorHandler(() {
      List<ProductsList> tempList=[];
      for(int i=0;i<data.length;i++){
        tempList.add(ProductsList.fromMap(data[i]));
      }
      return tempList;
    });
    return productListModel;
  }

}