import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_application/screens/user_detail.dart';
import 'package:matrimony_application/utils/database_helper.dart';
import 'dart:convert';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreen();
}

class _BookmarkScreen extends State<BookmarkScreen> {
  List<Map<String, dynamic>> favoriteUsers = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFavoriteUsers();
    _searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadFavoriteUsers() async {
    final users = await DatabaseHelper.instance.getUsers();
    setState(() {
      favoriteUsers = users.where((user) => user['isFavorite'] == 1).toList();
      _filteredUsers = List.from(favoriteUsers); // Initialize filtered list
    });
  }

  void _filterUsers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = favoriteUsers.where((user) {
        String name = user['name']?.toLowerCase() ?? "";
        String email = user['email']?.toLowerCase() ?? "";
        String city = user['city']?.toLowerCase() ?? "";
        return name.contains(query) || email.contains(query) || city.contains(query);
      }).toList();
    });
  }

  void _showFavoriteConfirmationDialog(BuildContext context, VoidCallback onConfirm) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          'Confirm Action',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Are you sure you want to change the favorite status?',
            style: TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'No',
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Yes'),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              onConfirm(); // Perform the favorite action
            },
          ),
        ],
      ),
    );
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search by name, email, or city",
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: BorderSide(color: Colors.redAccent, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),

            // Scrollable List
            Expanded(
              child: _filteredUsers.isEmpty
                  ? Center(
                child: Text(
                  "No favorite users found.",
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: _filteredUsers.length,
                itemBuilder: (context, index) {
                  return listCard(
                    index,
                    _filteredUsers[index]['id'],
                    _filteredUsers[index]['name'],
                    _filteredUsers[index]['email'],
                    _filteredUsers[index]['phone'],
                    _filteredUsers[index]['gender'],
                    _filteredUsers[index]['dob'],
                    _filteredUsers[index]['city'],
                    _filteredUsers[index]['hobbies'],
                    _filteredUsers[index]['isFavorite'] == 1,
                  );
                },
              ),
            ),
          ],
        )
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
                hobbies: hobbies is String
                    ? (jsonDecode(hobbies) as List<dynamic>).cast<String>() // Convert JSON string to List<String>
                    : (hobbies as List<String>?),
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
                      size: 25,
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.amberAccent,
                    ),
                    onPressed: () {
                      _showFavoriteConfirmationDialog(context, () async {
                        await DatabaseHelper.instance.updateUser(
                          id,
                          {'isFavorite': isFavorite ? 0 : 1},
                        );
                        _loadFavoriteUsers();
                      });
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