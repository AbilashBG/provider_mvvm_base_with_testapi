import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mvvmbasic/providers/home_provider.dart';
import 'package:mvvmbasic/providers/local_providers/local_provider.dart';
import 'package:mvvmbasic/utils/global_variables.dart';
import 'package:mvvmbasic/utils/pref_keys.dart';
import 'package:mvvmbasic/utils/routes.dart';
import 'package:provider/provider.dart';

import '../providers/local_providers/app_local_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppLocalProviders(child: (context, localProvider, snapshot) {
      return ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        builder: (context, provider) => Consumer<HomeProvider>(
          builder: (context, provider, snapshot) {
            ///the provider has already created and that store in the get
            Get.lazyPut(() => provider);

            return Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(provider.value.toString(),),
                            ElevatedButton(
                              onPressed: () {
                                provider.decrement();
                              },
                              child: Text("Decrement"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: size.height - 200,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          mainAxisSpacing: 80.0, // Spacing between rows
                          crossAxisSpacing: 20.0, // Spacing between columns
                        ),
                        itemCount: provider.productList?.length,
                        itemBuilder: (context, index) {
                          var item = provider.productList?[index];
                          print("${provider.productList?.length}");
                          return InkWell(
                            child: Card(
                              child: Image.network(
                                "${item?.image}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            onTap: () {
                              var productId = item?.id;
                              navigatorKey.currentState?.pushNamed(
                                  AppRoutes.PRODUCTVIEWSCREEN.name,
                                  arguments: [
                                    productId,
                                    provider.increment,
                                  ]);
                              provider.starFunction();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ));
          },
        ),
      );
    });
  }
}
