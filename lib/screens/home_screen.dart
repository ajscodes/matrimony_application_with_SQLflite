import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  late Timer _timer;

  final List<String> images = [
    "assets/images/scroll1.jpg",
    "assets/images/scroll2.jpeg",
    "assets/images/scroll3.jpeg",
    "assets/images/scroll4.jpeg"
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Reset to the first image smoothly
        _pageController.jumpToPage(0); // Instantly move to the first image
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            UserAccountsDrawerHeader(
              accountName: Text("Ayush Maradia"),
              accountEmail: Text("23010101159@darshan.ac.in"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset('assets/images/me.jpeg',
                    fit: BoxFit.cover,
                    height: 70,
                    width: 70,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
            ),

            // Home
            ListTile(
              leading: Icon(Icons.home, color: Colors.redAccent),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),

            // User List
            ListTile(
              leading: Icon(Icons.list, color: Colors.redAccent),
              title: Text("User List"),
              onTap: () {
                Navigator.pushNamed(context, '/userlist');
              },
            ),

            // Bookmarks
            ListTile(
              leading: Icon(Icons.bookmark, color: Colors.redAccent),
              title: Text("Bookmarks"),
              onTap: () {
                Navigator.pushNamed(context, '/bookmark');
              },
            ),

            // About Us
            ListTile(
              leading: Icon(Icons.info, color: Colors.redAccent),
              title: Text("About Us"),
              onTap: () {
                Navigator.pushNamed(context, '/aboutus');
              },
            ),

            Divider(),

            // Logout
            ListTile(
              leading: Icon(CupertinoIcons.power, color: CupertinoColors.systemRed),
              title: Text("Exit"),
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text(
                      'Exit App',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Are you sure you want to exit the app?',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: CupertinoColors.activeBlue),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: Text('Exit'),
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          SystemNavigator.pop(); // Exit app
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 220,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10,),
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/adduser');
                    },
                    icon: Icon(Icons.person_add, color: Colors.white),
                    label: Text('Add User'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/userlist');
                    },
                    icon: Icon(Icons.list, color: Colors.white),
                    label: Text('User List'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/bookmark');
                    },
                    icon: Icon(Icons.favorite, color: Colors.white),
                    label: Text('Favorite List'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/aboutus');
                    },
                    icon: Icon(Icons.info, color: Colors.white),
                    label: Text('About Us'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}