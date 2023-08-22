import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:mvvmbasic/providers/home_provider.dart';
import 'package:mvvmbasic/providers/local_providers/app_provider.dart';
import 'package:mvvmbasic/providers/local_providers/local_provider.dart';
import 'package:mvvmbasic/utils/global_variables.dart';
import 'package:mvvmbasic/utils/routes.dart';
import 'package:mvvmbasic/utils/style.dart';
import 'package:mvvmbasic/view/home_screen.dart';
import 'package:mvvmbasic/view/product_view_screen.dart';
import 'package:mvvmbasic/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

//wrap all class with LocaleProvider inorder use localizations
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const AppProviders(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    callsetfun();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Future.microtask(
        () => context.read<LocaleProvider>().appResume(),
      );
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/utils/i18n/'];
    return Consumer<LocaleProvider>(
      builder: (context, provider, snapshot) {
        Get.lazyPut<LocaleProvider>(() => provider);
        return Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          },
          child: MyMaterialApp(context, provider, snapshot),
        );
      },
    );
  }

  void callsetfun() async {
    context.read<LocaleProvider>().init();
  }
}

class MyMaterialApp extends StatelessWidget {
  final LocaleProvider provider;
  final BuildContext context;
  final Widget? snapshot;

  const MyMaterialApp(this.context, this.provider, this.snapshot, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.roboto(textStyle: textTheme.bodyMedium),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: primaryColor,
        ),
        useMaterial3: true,
      ),
      supportedLocales: supportedLocalesList,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      locale: provider.locale,
      initialRoute: AppRoutes.SPLASHSCREEN.name,
      routes: {
        AppRoutes.SPLASHSCREEN.name: (context) => const SplashScreen(),
        AppRoutes.HOMESCREEN.name: (context) => const HomeScreen(),
        AppRoutes.PRODUCTVIEWSCREEN.name: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as List;
          final id = args[0];
          final productView = args[1];
          return  ProductViewScreen(productId: "${id}",incrementCallBack:productView);
        },
      },
    );
  }
}
