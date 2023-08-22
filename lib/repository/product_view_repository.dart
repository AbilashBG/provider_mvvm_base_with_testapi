import 'package:mvvmbasic/utils/api_end_points.dart';

import '../data_model/product_list_model.dart';
import '../data_model/product_view_model.dart';
import '../data_services/api_helper.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';

class ProductViewRepository {
  final ApiHelper _apiHelper = ApiHelper();

  Future<dynamic> productView(String id) async {
    var data = await errorHandler(
        _apiHelper.multiMethod(
          BASEURL,
          PRODUCTVIEW+"${id}",
          methodtype: ApiTypeEnum.GET,
        ),true,true);
    if (data == null) return null;

    print(data);
    ///data load error
    var productViewModel = modelErrorHandler(() {

      return ProductViewModel.fromMap(data);
    });
    return productViewModel;
  }

}