import 'package:chat_app/app/modules/login/presentation/bloc/login_event.dart';
import 'package:chat_app/app/modules/login/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';
import 'widgets/login_button.dart';
import 'widgets/register_button.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc loginBloc;

  const LoginPage({super.key, required this.loginBloc});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();
  final PageController _pageController = PageController();

  bool isLoginSelected = true;

  @override
  void initState() {
    super.initState();

    widget.loginBloc.state.listen((state) {
      if (state is LoginSuccess) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login Successful!')));
      } else if (state is LoginFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }
    });
  }

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    widget.loginBloc.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleTab(bool isLogin) {
    setState(() {
      isLoginSelected = isLogin;
    });
    _pageController.animateToPage(
      isLogin ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: 500,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => _toggleTab(true),
                          child: Column(
                            children: [
                              Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isLoginSelected
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 3.0,
                                width: isLoginSelected ? 60 : 0,
                                color: const Color.fromARGB(255, 44, 192, 163),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _toggleTab(false),
                          child: Column(
                            children: [
                              Text(
                                'Cadastrar-se',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: !isLoginSelected
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 3.0,
                                width: !isLoginSelected ? 100 : 0,
                                color: const Color.fromARGB(255, 44, 192, 163),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildLoginForm(),
                          _buildRegisterForm(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Fazer login",
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 26),
        CustomTextField(
          controller: emailLoginController,
          labelText: 'E-mail',
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: passwordLoginController,
          labelText: 'Senha',
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
                backgroundColor: const Color.fromARGB(255, 44, 192, 163),
                padding: const EdgeInsets.symmetric(vertical: 17.0),
                onPressed: () {
                  final email = emailLoginController.text;
                  final password = passwordLoginController.text;

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
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Criar uma conta",
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 26),
        CustomTextField(
          controller: TextEditingController(),
          labelText: 'Nome',
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: emailRegisterController,
          labelText: 'E-mail',
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: passwordRegisterController,
          labelText: 'Senha',
          isPassword: true,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: RegisterButton(
            backgroundColor: const Color.fromARGB(255, 44, 192, 163),
            padding: const EdgeInsets.symmetric(vertical: 17.0),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
