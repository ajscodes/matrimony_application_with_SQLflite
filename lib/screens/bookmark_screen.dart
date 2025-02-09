import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_application/screens/user_detail.dart';
import 'package:matrimony_application/utils/database_helper.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreen();
}

class _BookmarkScreen extends State<BookmarkScreen> {
  List<Map<String, dynamic>> favoriteUsers = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteUsers();
  }

  Future<void> _loadFavoriteUsers() async {
    final users = await DatabaseHelper.instance.getUsers();
    setState(() {
      favoriteUsers = users.where((user) => user['isFavorite'] == 1).toList();
    });
  }

  Future<void> _deleteUser(int id) async {
    await DatabaseHelper.instance.deleteUser(id);
    _loadFavoriteUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Favorite Users", style: TextStyle(color: Colors.white)),
      ),
      body: favoriteUsers.isEmpty
          ? Center(child: Text("No favorite users found."))
          : ListView.builder(
        itemCount: favoriteUsers.length,
        itemBuilder: (context, index) {
          return listCard(
            index,
            favoriteUsers[index]['id'],
            favoriteUsers[index]['name'],
            favoriteUsers[index]['email'],
            favoriteUsers[index]['phone'],
            favoriteUsers[index]['gender'],
            favoriteUsers[index]['dob'],
            favoriteUsers[index]['city'],
            favoriteUsers[index]['hobbies'],
            favoriteUsers[index]['isFavorite'] == 1,
          );
        },
      ),
    );
  }

  Widget listCard(index, int id, username, email, phoneNumber, gender, dob, city, hobbies, bool isFavorite) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetail(
                name: username,
                email: email,
                gender: gender,
                dob: dob,
                phone: phoneNumber,
                city: city,
                hobbies: hobbies.split(', '), // Convert back to list
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Profile Picture
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("https://picsum.photos/id/237/200/300"),
                    backgroundColor: Colors.grey[200],
                  ),
                  //if (isVerified)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(Icons.verified_rounded, color: Colors.blue, size: 18),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.engineering_outlined,color: Colors.indigo,size: 22,),
                        const SizedBox(width: 4),
                        Text(
                          "Insert occupation here",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Star & More Actions
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.amberAccent,
                    ),
                    onPressed: () async {
                      await DatabaseHelper.instance.updateUser(
                        id,
                        {'isFavorite': isFavorite ? 0 : 1},
                      );
                      _loadFavoriteUsers();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
