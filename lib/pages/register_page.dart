import 'package:flutter/material.dart';
import 'package:sokolov_chat/services/auth/auth_service.dart';
import 'package:sokolov_chat/components/my_button.dart';
import 'package:sokolov_chat/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) async {
    final authService = AuthService();

    if (_pwController.text == _confirmPwController.text) {
      try {
        await authService.signUpWithEmailPassword(
            _emailController.text, _pwController.text);
      } catch (e) {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(e.toString()),
                  ));
        }
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('Пароли не совпадают'),
              ));
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
              'Создание аккаунта',
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
              height: 10,
            ),
            MyTextfield(
              hintText: 'Повторите пароль',
              obscureText: true,
              controller: _confirmPwController,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              text: 'Регистрация',
              onTap: () => register(context),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'У вас уже есть аккаунт? ',
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    'Войти',
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
