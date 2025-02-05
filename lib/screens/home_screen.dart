import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  @override
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
                child: Icon(Icons.person, size: 40, color: Colors.redAccent),
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
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text("Logout"),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'Search User',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () => {
              Navigator.pushNamed(context, '/adduser')
            }, child: Text('Add User')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () => {}, child: Text('User List')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () => {}, child: Text('Favorite list')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () => {}, child: Text('About us')),
          ],
        ),
      ),
    );
  }
}
