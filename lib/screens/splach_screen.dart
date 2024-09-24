import 'package:chat_app/screens/border_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // إخفاء الـ status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // إعدادات الأنيميشن
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // مدة الحركة
    );

    _animation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // نوع الحركة
      ),
    );

    _animationController.forward(); // بدء الحركة

    // الانتقال بعد 5 ثوانٍ
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation, // تطبيق الأنيميشن على الحجم
              child: SizedBox(
                height: 250,
                width: 250,
                child: Image.asset('assets/images/chat-app-logo.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
