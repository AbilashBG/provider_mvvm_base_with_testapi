import 'package:get/get.dart';
import 'package:mvvmbasic/providers/home_provider.dart';

class MyBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeProvider>(() => HomeProvider());
  }

}