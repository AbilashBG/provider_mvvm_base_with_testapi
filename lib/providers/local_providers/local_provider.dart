import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvvmbasic/helper/db_helper.dart';

import '../../repository/local_repository.dart';
import '../../services/notification_service.dart';
import '../../utils/global_variables.dart';
import '../../utils/shared_pref.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = supportedLocalesList[0];
  final LocalRepository _localRepository = LocalRepository();

  bool _isload = false;

  bool get isload => _isload;

  Locale get locale => _locale;

  late SharedPreferencesLocal _sharedPref;

  SharedPreferencesLocal get sharedPref => _sharedPref;

  late DBHelper _dbHelper;

  DBHelper get dbHelper => _dbHelper;

  String? _fcmtoken = "";

  String? get fcmtoken => _fcmtoken;

  final NotificationService _notificationService = NotificationService.instance;

  NotificationService get notificationService => _notificationService;
  final Connectivity _connectivity = Connectivity();
  var isint = false;

  var msgdata = {};

  void init() async {
    isint = true;
    _isload = true;
    _notificationService.init(ongetnotification, onTokenRefresh);
    _sharedPref = await SharedPreferencesLocal().init();
    setFcmToken();



    _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        if (_isload && result != ConnectivityResult.none) {

        }
      },
    );

    notifyListeners();
  }

  void appResume() {
    msgdata.addAll({"title": "resume"});
    print("Appresumed");
  }

  void setLocale(Locale locale) {
    //if (!supportedLocalesList.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void creatdDB() {
    _dbHelper = DBHelper().instance;
    dbHelper.init();
  }

  void ongetnotification(RemoteMessage data) {
    msgdata.addAll({"title": "${data.notification?.title}"});
    notifyListeners();
  }

  void onTokenRefresh(String? token) {
    _fcmtoken = token;
    notifyListeners();
  }

  void setFcmToken() {
    notificationService.setFCMToken();
    notifyListeners();
  }

  // void configapp() async {
  //   var configdata = await _localRepository.configApp();
  //   if (configdata != null) {
  //     _isload = false;
  //   }
  //   notifyListeners();
  // }
}
