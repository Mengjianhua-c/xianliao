import 'package:xianliao/services/cli.dart';
import 'package:flutter/material.dart';
import 'env.dart';
import 'routes/routes.dart';
// ignore: unused_import
import 'services/real_api.dart';
import 'services/mock_api.dart';
import 'blocs/bloc_provider.dart';
import 'blocs/movies/movies_bloc.dart';
// ignore: unused_import
import 'package:xianliao/pages/home.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:xianliao/services/cache/sql_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  dio.interceptors.add(CustomInterceptors());
  Env.apiClient = RealAPI();
  WidgetsFlutterBinding.ensureInitialized();
  DbUtil().init().then((value){
    print('init dio headers');
    initOptions();
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '闲聊',
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      localizationsDelegates: [
        // 这行是关键
        RefreshLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('zh'),
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        //print("change language");
        return locale;
      },
    );
  }
}
