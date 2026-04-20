import 'package:exams_app/features/authentication/presentation/auth/cubit/auth_cubit.dart';
import 'package:exams_app/features/authentication/presentation/auth/cubit/auth_even.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageTest extends StatelessWidget {
  const MainPageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthCubit>().doEvent(Logout());
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
