import 'package:chat/components/auth_form.dart';
import 'package:chat/domain/models/auth_form_data.dart';
import 'package:chat/domain/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData authData) async {
    try {
      setState(() => _isLoading = true);

      if (authData.isLogin) {
        await AuthService().login(authData.email, authData.password);
      } else {
        await AuthService().signup(
          authData.name,
          authData.email,
          authData.password,
          authData.image,
        );
      }
    } catch (error) {
      //TO-DO
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
