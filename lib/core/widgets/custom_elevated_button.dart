import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String child;
  final void Function()? onTap;
  final bool isError;

  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onTap,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: isError ? null : onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isError ? Colors.grey : Colors.blue,
            borderRadius: BorderRadius.circular(100),
          ),
          width: double.infinity,
          height: 48,
          child: Center(
            child: Text(
              child,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
