// ignore_for_file: prefer_const_constructors

import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/forget_passward.dart';
import 'package:chat_app/pages/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  const Login({super.key, required String email, required String password});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  String? _errorMessage;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isLoading = false; // حالة التحميل

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // دالة لعرض Snackbar
  void _showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  // دالة لعملية تسجيل الدخول
  Future<void> _loginUser(BuildContext context) async {
    setState(() {
      _isEmailValid = _emailController.text.isNotEmpty;
      _isPasswordValid = _passwordController.text.isNotEmpty;
      _isLoading = true; // بدء التحميل
    });

    if (_isEmailValid && _isPasswordValid) {
      try {
        // استخدم signInWithEmailAndPassword لتسجيل الدخول
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        setState(() {
          _errorMessage = null;
          _isLoading = false; // إيقاف التحميل
        });

      Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ChatPage(email: _emailController.text), // تمرير البريد الإلكتروني
  ),
);

      } catch (e) {
        setState(() {
          _errorMessage = "Login failed. Please try again.";
          _isLoading = false; // إيقاف التحميل
        });
        _showSnackbar(context, 'Login failed. Please try again.', Colors.red);
      }
    } else {
      setState(() {
        _isLoading = false; // إيقاف التحميل
      });
      _showSnackbar(context, 'Please fill in all fields', Colors.red);
    }

  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading, // ربط حالة التحميل
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/chat-app-logo.png'),
                      const SizedBox(height: 20),
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff004170),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _emailController,
                        labelText: 'Username',
                        prefixIcon: Icons.person,
                        isValid: _isEmailValid,
                        errorText: 'Email is required',
                      ),
                      const SizedBox(height: 20),
                      _buildPasswordField(),
                      const SizedBox(height: 20),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20),
                      _buildLoginButton(context),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text("Or login with",
                          style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 20),
                      _buildSocialLoginButtons(),
                      const SizedBox(height: 20),
                      _buildFooterButtons(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ويدجت مخصصة لحقول الإدخال
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    required bool isValid,
    required String errorText,
  }) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        setState(() {
          isValid = value.isNotEmpty;
        });
      },
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Color(0xff004170),
        ),
        prefixIcon: Icon(prefixIcon, color: Color(0xff004170)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isValid ? Color(0xff004170) : Colors.red,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isValid ? Color(0xff004170) : Colors.red,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: isValid ? null : errorText,
      ),
    );
  }

  // ويدجت لحقل كلمة المرور مع أيقونة إظهار/إخفاء
  Widget _buildPasswordField() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return TextField(
          controller: _passwordController,
          obscureText: _obscureText,
          onChanged: (value) {
            setState(() {
              _isPasswordValid = value.isNotEmpty;
            });
          },
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Color(0xff004170)),
            prefixIcon: const Icon(Icons.lock, color: Color(0xff004170)),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Color(0xff004170),
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _isPasswordValid ? Color(0xff004170) : Colors.red,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _isPasswordValid ? Color(0xff004170) : Colors.red,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: _isPasswordValid ? null : 'Password is required',
          ),
        );
      },
    );
  }

  // ويدجت لزر تسجيل الدخول
  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _loginUser(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff004170),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'LOGIN',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  // ويدجت لعرض أزرار تسجيل الدخول عبر الشبكات الاجتماعية
  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Image.asset('assets/images/google.png', width: 50, height: 50),
          onPressed: () {
            // تسجيل الدخول باستخدام Google
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          icon:
              Image.asset('assets/images/facebook.png', width: 50, height: 50),
          onPressed: () {
            // تسجيل الدخول باستخدام Facebook
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: Image.asset('assets/images/apple.png', width: 50, height: 50),
          onPressed: () {
            // تسجيل الدخول باستخدام Apple
          },
        ),
      ],
    );
  }

  // ويدجت لعرض أزرار "نسيت كلمة السر" و "إنشاء حساب"
  Widget _buildFooterButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            // التنقل إلى صفحة استعادة كلمة المرور
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmPasswordScreen(),
              ),
            );
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.red),
          ),
        ),
        const SizedBox(width: 20),
        TextButton(
          onPressed: () {
            // التنقل إلى صفحة إنشاء حساب جديد
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUp(),
              ),
            );
          },
          child: const Text(
            'Create an Account',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}
