// lib/app/modules/login/presentation/pages/login_page.dart

import 'package:chat_app/app/modules/login/presentation/bloc/login_event.dart';
import 'package:flutter/material.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc loginBloc;

  const LoginPage({super.key, required this.loginBloc});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.loginBloc.state.listen((state) {
      if (state is LoginSuccess) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login Successful! ')));
      } else if (state is LoginFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    widget.loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            StreamBuilder<LoginState>(
              stream: widget.loginBloc.state,
              initialData: LoginInitial(),
              builder: (context, snapshot) {
                if (snapshot.data is LoginLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ElevatedButton(
                  onPressed: () {
                    final email = emailController.text;
                    final password = passwordController.text;

                    widget.loginBloc.eventSink.add(SubmitButtonPressed(
                      email: email,
                      password: password,
                    ));
                  },
                  child: const Text('Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
