import 'package:exams_app/config/di/di.dart';
import 'package:exams_app/features/authentication/presentation/auth/cubit/auth_cubit.dart';
import 'package:exams_app/features/authentication/presentation/auth/pages/auth_page.dart';
import 'package:exams_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:exams_app/features/authentication/presentation/register/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            snackBarTheme: const SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.redAccent,
              contentTextStyle: TextStyle(color: Colors.white),
            ),
          ),
          home: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<LoginCubit>()),
              BlocProvider(create: (_) => getIt<RegisterCubit>()),
              BlocProvider(create: (_) => getIt<AuthCubit>()),
            ],
            child: MultiBlocListener(
              listeners: [
                BlocListener<LoginCubit, LoginState>(
                  listener: (context, state) {
                    final error = state.loginState.errorMessage;
                    if (error != null && error.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    }

                    if (state.loginState.data != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => Scaffold(body: Center(child: Text("HOME PAGE"),),),
                        ),
                      );
                    }
                  },
                ),

                BlocListener<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    final error = state.registerState.errorMessage;
                    if (error != null && error.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    }

                    if (state.registerState.data != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => Scaffold(body: Center(child: Text("HOME PAGE"),),),
                        ),
                      );
                    }
                  },
                ),

                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    final error = state.authState.errorMessage;
                    if (error != null && error.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                    }
                  },
                ),
              ],
              child: const AuthPage(),
            ),
          ),
        );
      },
    );
  }
} 