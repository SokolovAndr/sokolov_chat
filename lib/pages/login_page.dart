import 'package:flutter/material.dart';
import 'package:sokolov_chat/services/auth/auth_service.dart';
import 'package:sokolov_chat/components/my_button.dart';
import 'package:sokolov_chat/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
    } catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Добро пожаловать, мы скучали!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextfield(
              hintText: 'Email',
              obscureText: true,
              controller: _emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextfield(
              hintText: 'Пароль',
              obscureText: true,
              controller: _pwController,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              text: 'Вход',
              onTap: () => login(context),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Нет аккаунта? ',
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
