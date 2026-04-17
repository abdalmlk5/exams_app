import 'package:exams_app/features/authentication/presentation/auth_manager/cubit/auth_manager_cubit.dart';
import 'package:exams_app/features/authentication/presentation/auth_manager/cubit/auth_manager_event.dart';
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
            context.read<AuthManagerCubit>().doEvent(Logout());
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}

