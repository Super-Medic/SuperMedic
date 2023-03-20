import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:super_medic/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:super_medic/provider/check_box_provider.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/pages/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:super_medic/pages/medicinePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_medic/widgets/calender_widgets/utils.dart';
import 'package:super_medic/provider/medicine_provider.dart';
import 'package:flutter/services.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print('백 그라운드');
  print(message.data.toString());
  print(message.notification!.title);
  print('================================================================');
}

// ignore: prefer_const_constructors
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp() 호출 전 Flutter SDK 초기화
  await dotenv.load(fileName: "assets/config/.env");
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  KakaoSdk.init(nativeAppKey: dotenv.env['AppKey']);
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('first_run') ?? true) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
    prefs.setBool('first_run', false);
  }

  // 세로모드 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // MultiProvider를 통해 변화에 대해 구독
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => CalendarData()),
        ChangeNotifierProvider(create: (_) => CheckBoxProvider()),
        ChangeNotifierProvider(create: (_) => MedicineTake()),
      ],
      child: GestureDetector(
        // 사용자 탭 감지
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
        },
        child: MaterialApp(
          title: 'Super_medict',
          debugShowCheckedModeBanner: false, //AppBar DEBUG 리본 없애기
          theme: ThemeData(
            splashColor: Colors.transparent, //버튼 클릭 시 물결 없애기
            highlightColor: Colors.transparent, //버튼 클릭 시 물결 없애기
          ),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!,
            );
          },
          localizationsDelegates: const [
            //요일 구하기
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', 'KR'),
          ],
          locale: const Locale('ko'),
          home: const SplashScreen(),
          routes: {
            'medicine': (context) => const MedicinePage(),
            'splash': (context) => const SplashScreen(),
          },
        ),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
