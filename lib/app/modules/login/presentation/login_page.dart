import 'package:chat_app/app/modules/login/presentation/bloc/login_event.dart';
import 'package:chat_app/app/modules/login/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';
import 'widgets/login_button.dart';

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
      backgroundColor: const Color.fromARGB(255, 54, 54, 54),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Flutter Chat",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 26),
              CustomTextField(
                controller: emailController,
                labelText: 'E-mail',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
                isPassword: true,
              ),
              const SizedBox(height: 16),
              StreamBuilder<LoginState>(
                stream: widget.loginBloc.state,
                initialData: LoginInitial(),
                builder: (context, snapshot) {
                  final isLoading = snapshot.data is LoginLoading;

                  return SizedBox(
                    width: double.infinity,
                    child: LoginButton(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;

                        widget.loginBloc.eventSink.add(SubmitButtonPressed(
                          email: email,
                          password: password,
                        ));
                      },
                      isLoading: isLoading,
                    ),
                  );
                },
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Não possui uma conta? ',
                        style: TextStyle(color: Colors.white)),
                    InkWell(
                      child: const Text('Cadastre-se',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
