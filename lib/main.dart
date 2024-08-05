import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_tutorial_hostel_management/api_services/api_provider.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_utils.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/screens/login_screen.dart';
import 'package:youtube_tutorial_hostel_management/features/student/screens/change_room_screen.dart';
import 'package:youtube_tutorial_hostel_management/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ApiProvider(
                baseUrl: ApiUtils.baseUrl, httpClient: http.Client()))
      ],
      child: const ScreenUtilInit(
        useInheritedMediaQuery: true,
        splitScreenMode: true,
        designSize: Size(375, 825),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hostel Management',
          home: LoginScreen(),
        ),
      ),
    );
  }
}
