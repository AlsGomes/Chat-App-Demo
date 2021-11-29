import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/domain/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(AuthFormData) onSubmit;

  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authData = AuthFormData();

  void _handleImagePick(File image) {
    _authData.image = image;
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(_authData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authData.isSignup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              if (_authData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _authData.name,
                  onChanged: (name) => _authData.name = name,
                  decoration: const InputDecoration(
                    label: Text("Nome"),
                  ),
                  validator: (_name) {
                    var name = _name ?? '';
                    name = name.trim();

                    if (name.length < 3) {
                      return "Nome precisa ter mais que 3 caracteres";
                    }

                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _authData.email,
                onChanged: (email) => _authData.email = email,
                decoration: const InputDecoration(
                  label: Text("E-mail"),
                ),
                validator: (_email) {
                  var email = _email ?? '';
                  email = email.trim();

                  if (!email.contains("@")) {
                    return "E-mail inválido";
                  }

                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _authData.password,
                onChanged: (password) => _authData.password = password,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Senha"),
                ),
                validator: (_password) {
                  var password = _password ?? '';

                  if (password.length < 6) {
                    return "Senha deve conter no mínimo 6 caracteres";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _authData.isLogin ? "Entrar" : "Cadastrar",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                child: Text(
                  _authData.isLogin
                      ? "Criar uma nova conta?"
                      : "Já possui uma conta?",
                  style: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  setState(() {
                    _authData.toggleAuthMode();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
