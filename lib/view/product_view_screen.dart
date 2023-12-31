import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mvvmbasic/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../providers/local_providers/app_local_provider.dart';
import '../providers/product_view_provider.dart';

class ProductViewScreen extends StatefulWidget {
  final String? productId;
  const ProductViewScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {

  ///the stored provider which is in the get has used here ,we can use this wherever like this
  HomeProvider homeProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    print("productId ${widget.productId}");
    Size size = MediaQuery.of(context).size;
    return AppLocalProviders(child: (context,localProvider,snapshot){
      return  ChangeNotifierProvider(
        create:(_)=>ProductViewProvider("${widget.productId}"),builder: (context,provider)=> Consumer<ProductViewProvider>(
        builder: (context, provider, snapshot) {
          Get.lazyPut<ProductViewProvider>(() => provider);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body:provider.isloading?Center(child: CircularProgressIndicator(),): Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.network("${provider.productViewModel?.image}"),
                  ),
                  SizedBox(height: 20,),
                  Text("\$ ${provider.productViewModel?.price}",style: TextStyle(fontSize: 19,),),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 16,),
                      child: Text("\$ ${provider.productViewModel?.title}",style: TextStyle(fontSize: 19,),)),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20,),
                      child: Text("\$ ${provider.productViewModel?.description}",style: TextStyle(fontSize: 19,),)),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    homeProvider.increment();
                  }, child: Text("Press Here"),),
                ],
              ),
            ),
          );
        },
      ), );
    });
  }
}
