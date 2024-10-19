import 'package:flutter/material.dart';
import 'package:project_today/screen/group_setting/view/group_setting_view.dart';
import 'package:project_today/screen/home/timer_screens.dart';
import 'package:project_today/screen/home/waiting_screens.dart';
import 'package:project_today/screen/home/diary_screens.dart';
import 'package:project_today/screen/generate/view/generate_view.dart';
import 'package:project_today/screen/group/view/group_view.dart';
import 'package:project_today/screen/home/view/home_view.dart';
import 'package:project_today/screen/invite/view/invite_view.dart';
import 'package:project_today/screen/prev/view/prev_view.dart';
import 'package:project_today/screen/onboard/view/onboard_view.dart';
import 'package:project_today/screen/read/view/read_view.dart';
import 'package:project_today/screen/setting/view/setting_view.dart';
import 'package:project_today/screen/splash/view/splash_view.dart';
import 'package:project_today/screen/login/view/login_view.dart';
import 'package:project_today/screen/write/view/write_view.dart';
import 'package:project_today/screen/change/view/change_view.dart';
import 'package:project_today/screen/member/view/member_view.dart';
import 'package:project_today/screen/participate/view/participate_view.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');

  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
      nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
      javaScriptAppKey: dotenv.env['KAKAO_JS_KEY']);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오늘은',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Pretendard",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white, // 기본 배경 색 흰색으로 설정
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.pink, // 로딩 인디케이터 색 핑크로 설정
        ),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => SplashView(),
        '/login': (context) => LoginView(),
        '/group': (context) => GroupView(), //내 그룹 리스트 렌더 뷰
        '/onboard': (context) => OnboardView(),
        '/setting': (context) => SettingView(),
        '/change': (context) => ChangeView(),
        '/generate': (context) => GenerateView(), //그룹 생성 뷰
        '/prev': (context) => PrevView(),
        '/read': (context) => ReadView(),
        '/timer': (context) => TimerView(), //교환일기 시작 전 타이머 뷰
        '/waiting': (context) => WaitingView(), //교환일기 내 차례 아닐 때 뷰
        '/diary': (context) => DiaryView(), //교환일기 내 차례일 때 뷰
        '/write': (context) => WriteView(),
        '/member': (context) => MemberView(),
        '/participate': (context) => ParticipateView(), //참가 코드 입력 뷰
        '/invite': (context) => InviteView(), //유효한 참가 코드 시 그룹 정보 렌더 뷰
        '/groupsetting': (context) => GroupSettingView(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final arguments = settings.arguments as Map<String, dynamic>?;
          if (arguments != null && arguments.containsKey('id')) {
            final int groupId = arguments['id'];
            return MaterialPageRoute(
              builder: (context) => HomeView(groupId: groupId), //교환일기 홈 분기점
            );
          }
        }
        return null;
      },
      initialRoute: '/',
    );
  }
}
