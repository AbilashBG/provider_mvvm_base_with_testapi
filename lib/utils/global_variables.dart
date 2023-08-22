library my_prj.globals;

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../providers/local_providers/local_provider.dart';

var appname = "app-name".i18n();

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

var supportedLocalesList = [
  const Locale('en', 'US'),
  const Locale('hi', 'IN'),
  const Locale('ta', 'IN'),
];

var providers = [
  ChangeNotifierProvider(
    create: (_) => LocaleProvider(),
  ),
];
