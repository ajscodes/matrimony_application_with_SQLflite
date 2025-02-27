import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_application/screens/user_detail.dart';
import 'package:matrimony_application/screens/user_form.dart';
import 'package:matrimony_application/utils/database_helper.dart';
import 'dart:convert';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  double x = 300;
  double y = 525;
  List<Map<String, dynamic>> user_List = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _searchController.addListener(_filterUsers);
  }

  Future<void> _loadUsers() async {
    final users = await DatabaseHelper.instance.getUsers();
    setState(() {
      user_List = users;
      _filteredUsers = users;
    });
  }

  void _filterUsers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = user_List
          .where((user) => user['name'].toLowerCase().contains(query) ||
          user['email'].toLowerCase().contains(query) ||
          user['city'].toLowerCase().contains(query))
          .toList();
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
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("User List", style: TextStyle(color: Colors.white)),
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
                    borderSide: BorderSide(color: Colors.redAccent,width: 2)
                ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(18.0)),
                  ),
              onChanged: (value) => _filterUsers(), // Calls filter function on input
            ),
          ),

          // User List & Floating Action Button inside Stack
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 80.0), // Space for FAB
                  child: _filteredUsers.isEmpty
                      ? Center(child: Text("No users found.", style: TextStyle(fontSize: 18)))
                      : ListView.builder(
                    padding: EdgeInsets.only(bottom: 16.0),
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

                // Floating Action Button with Background
                Positioned(
                  left: x,
                  top: y,
                  child: Draggable(
                    feedback: Material(
                      type: MaterialType.transparency, // Removes background
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: FloatingActionButton(
                          backgroundColor: Colors.redAccent,
                          onPressed: () {},
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ),
                    childWhenDragging: SizedBox(), // Hides FAB when dragging
                    onDragEnd: (details) {
                      setState(() {
                        x = details.offset.dx.clamp(0.0, MediaQuery.of(context).size.width - 56);
                        y = details.offset.dy.clamp(0.0, MediaQuery.of(context).size.height - 56);
                      });
                    },
                    child: FloatingActionButton(
                      backgroundColor: Colors.redAccent,
                      onPressed: () {
                        Navigator.pushNamed(context, '/adduser');
                      },
                      child: Icon(Icons.add, color: Colors.white),
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
                        gender.toString().toLowerCase() == 'male'?Icon(Icons.male,color: Colors.blueAccent,):Icon(Icons.female,color: Colors.pinkAccent,),
                        const SizedBox(width: 4),
                        Text(
                          "Age will display here",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          city,
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
                      if (isFavorite) {
                        // Show confirmation dialog only when removing from favorites
                        _showFavoriteConfirmationDialog(context, () async {
                          await DatabaseHelper.instance.updateUser(
                            id,
                            {'isFavorite': 0}, // Removing from favorite
                          );
                          _loadUsers();
                        });
                      } else {
                        // Directly add to favorite without confirmation
                        DatabaseHelper.instance.updateUser(
                          id,
                          {'isFavorite': 1}, // Adding to favorite
                        ).then((_) => _loadUsers());
                      }
                    },
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserForm(
                              id: id,
                              name: username,
                              email: email,
                              phone: phoneNumber,
                              gender: gender,
                              dob: dob,
                              city: city,
                              hobbies: hobbies is String
                                  ? (jsonDecode(hobbies) as List<dynamic>).cast<String>() // Convert JSON string to List<String>
                                  : (hobbies as List<String>?),
                            ),
                          ),
                        ).then((value) {
                          if (value != null) _loadUsers();
                        });
                      } else if (value == 'delete') {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text(
                                'Confirm Deletion',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Are you sure you want to remove this user?',
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
                                  child: Text('Delete'),
                                  onPressed: () {
                                    _deleteUser(id);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );

                          },
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                      const PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                    icon: const Icon(Icons.more_vert, color: Colors.black),
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