import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sea_mobile/ui/pages/auth/register_page.dart';
import 'package:sea_mobile/ui/pages/auth/forgot_password_page.dart';
import 'package:sea_mobile/ui/widgets/input_field.dart';
import 'package:sea_mobile/config/base_api_config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        print("Google User: ${googleUser.email}");
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  Future<void> _handleSingin() async {
    try {
      Map<String, String> data = {
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
      };
      print("Data: $data"); // Always print data for debugging

      // Basic validation
      if (data['email']!.isEmpty || data['password']!.isEmpty) {
        print("Error: Email or password cannot be empty");
        return; // Stop execution if fields are empty
      }

      // Uncomment and use your API call
      // final response = await BaseApiService().postRequest('/auth/login', data);
      // if (response?.statusCode == 200) {
      //   Navigator.pushReplacementNamed(context, '/home');
      // } else {
      //   print("API error: ${response?.statusCode}");
      // }

      // Temporary navigation for testing (remove this after enabling API)
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print("Sign-in failed with error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      InputField(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'Enter your email',
                        type: InputFieldType.email,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Enter your password',
                        type: InputFieldType.password,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleSingin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _handleGoogleSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(FontAwesomeIcons.google,
                          color: Colors.blue, size: 20),
                      const SizedBox(width: 10),
                      const Text('Sign in with Google',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage())),
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: Colors.white)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",
                        style: TextStyle(color: Colors.white)),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
