import 'package:flutter/material.dart';

class LoginGoogleButton extends StatelessWidget {
  const LoginGoogleButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.g_mobiledata, size: 28),
        label: const Text('Continuar con Google'),
      ),
    );
  }
}
