import 'package:employeeapp/blocs/home/home_bloc.dart';
import 'package:employeeapp/pages/home.dart';
import 'package:employeeapp/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => serviceLocator.get<HomeBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Employee Details',
          theme: ThemeData(
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              bodySmall: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
