import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:user_auth/constants.dart';
import 'package:user_auth/controllers/auth_controller.dart';
import 'package:user_auth/screens/signup_screen.dart';
import 'package:user_auth/widgets/textformfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Welcome Back !', style: boldStyle)),
                const SizedBox(height: 20),

                // Email Field
                Text('Email', style: normalStyle),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  validate: (val) => emailvalidator(val),
                  hintText: 'email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.mail),
                ),
                const SizedBox(height: 20),

                // Password Field
                Text('Password', style: normalStyle),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  sufficIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: isVisible
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.remove_red_eye_outlined),
                  ),
                  validate: (val) => passwordValidator(val),
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  prefixIcon: const Icon(Icons.key),
                  hintText: 'password',
                  obscureText: isVisible,
                ),
                const SizedBox(height: 30),

                // Login Button
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 20)),
                        minimumSize:
                            MaterialStateProperty.all(const Size(100, 40)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthController.instance.login(
                              _emailController.text.trim(),
                              _passwordController.text.trim());
                        }
                      },
                      child: const Text('Login')),
                ),
                const SizedBox(height: 20),

                // Sign up if not have an account
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account yet? ',
                      style: smallStyle,
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: normalBoldStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => nextPage(context, const SignUpScreen()),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
