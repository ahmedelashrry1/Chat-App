import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/pages/login_in.dart'; // استيراد صفحة تسجيل الدخول

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  // متغيرات لحالة إخفاء وإظهار كلمة السر
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  // دالة لإنشاء حساب جديد باستخدام Firebase
  Future<void> _signUpUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = "Passwords do not match";
        _isLoading = false;
      });
      return;
    }

    try {
      // استخدام Firebase لإنشاء حساب جديد
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      setState(() {
        _errorMessage = null;
        _isLoading = false;
      });

      // الانتقال إلى صفحة تسجيل الدخول بعد إنشاء الحساب بنجاح
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Login(
                  email: 'email',
                  password: 'password',
                )),
      );
    } catch (e) {
      setState(() {
        _errorMessage = "Sign up failed. Please try again.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xff004170)),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login(
                                  email: 'email',
                                  password: 'password',
                                )),
                      );
                    },
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/chat-app-logo.png'),
                    SizedBox(height: 20),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff004170),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Color(0xff004170)),
                        prefixIcon: Icon(Icons.email, color: Color(0xff004170)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff004170)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff004170), width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible, // تعديل هنا
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color(0xff004170)),
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xff004170)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xff004170),
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff004170)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff004170), width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: !_confirmPasswordVisible, // تعديل هنا
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Color(0xff004170)),
                        prefixIcon: Icon(Icons.lock, color: Color(0xff004170)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xff004170),
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff004170)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff004170), width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _signUpUser(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff004170),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Sign Up',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
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
