import 'package:flutter/material.dart';
import '../../global/global_instances.dart';
import '../widgets/custom_text_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = false; // Loading state

  @override
  void dispose() {
    emailController.dispose(); // Dispose of controllers
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Signin',
            style: TextStyle(
              letterSpacing: 3,
              fontSize: 30,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/logo.png',
                height: 270,
              ),
            ),
          ),
          Form(
            key: formkey,
            child: Column(
              children: [
                CustomTextField(
                  textEditingController: emailController,
                  icon: Icons.email,
                  hintString: 'Email',
                  isObscure: false,
                  isEnabled: true,
                ),
                CustomTextField(
                  textEditingController: passwordController,
                  icon: Icons.lock,
                  hintString: 'Password',
                  isObscure: true,
                  isEnabled: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : () async { // Disable button while loading
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        isLoading = true; // Start loading
                      });
                      await authViewModel.validateSignInForm(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        context,
                      );
                      setState(() {
                        isLoading = false; // Stop loading
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isLoading // Show loading indicator
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            letterSpacing: 0,
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
