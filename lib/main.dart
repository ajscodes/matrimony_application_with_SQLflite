import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrimony_application/screens/aboutus_screen.dart';
import 'package:matrimony_application/screens/bookmark_screen.dart';
import 'package:matrimony_application/screens/home_screen.dart';
import 'package:matrimony_application/screens/list_page.dart';
import 'package:matrimony_application/screens/user_form.dart';
import 'package:matrimony_application/screens/navigation_screen.dart';
import 'package:matrimony_application/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parinay Matrimony',
      theme: ThemeData(
        primarySwatch: Colors.red,
        focusColor: Colors.redAccent,
        // Theme color
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => GetStartedScreen(),
        '/splash': (context) => SplashScreen(),
        '/navigation': (context) => NavigationScreen(),
        '/home': (context) => HomeScreen(),
        '/userlist': (context) => ListPage(),
        '/adduser': (context) => UserForm(),
        '/bookmark': (context) => BookmarkScreen(),
        '/aboutus': (context) => AboutusScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => NotFoundScreen()); // Handle unknown routes
      },
    );
  }
}

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.redAccent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/final.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo in circle
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.redAccent,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        fit: BoxFit.cover,
                        height: 105,
                        width: 105,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // App title
                  Text(
                    'Parinay Matrimony',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'This is an application that maintains records \nof registered users using CRUD with \ndatabase connectivity.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Button
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, '/splash'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 15,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started!',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Not Found')),
      body: Center(
        child: Text(
          '404 - Page Not Found',
          style: TextStyle(fontSize: 24, color: Colors.redAccent),
        ),
      ),
    );
  }
}