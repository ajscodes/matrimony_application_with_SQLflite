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
  Offset _fabPosition = Offset(300, 600);
  List<Map<String, dynamic>> user_List = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final users = await DatabaseHelper.instance.getUsers();
    setState(() {
      user_List = users;
    });
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
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0), // Space for FAB
            child: user_List.isEmpty
                ? Center(child: Text("No users found."))
                : ListView.builder(
              padding: EdgeInsets.only(bottom: 16.0),
              itemCount: user_List.length,
              itemBuilder: (context, index) {
                return listCard(
                  index,
                  user_List[index]['id'],
                  user_List[index]['name'],
                  user_List[index]['email'],
                  user_List[index]['phone'],
                  user_List[index]['gender'],
                  user_List[index]['dob'],
                  user_List[index]['city'],
                  user_List[index]['hobbies'],
                  user_List[index]['isFavorite'] == 1,
                );
              },
            ),
          ),

          // Floating Action Button with Background
          Positioned(
            left: _fabPosition.dx,
            top: _fabPosition.dy,
            child: Draggable(
              feedback: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserForm()),
                  ).then((value) {
                    if (value != null) _loadUsers();
                  });
                },
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.add, color: Colors.white),
              ),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  final screenSize = MediaQuery.of(context).size;
                  double newX = details.offset.dx.clamp(0.0, screenSize.width - 56);
                  double newY = details.offset.dy.clamp(0.0, screenSize.height - 120);
                  _fabPosition = Offset(newX, newY);
                });
              },
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserForm()),
                  ).then((value) {
                    if (value != null) _loadUsers();
                  });
                },
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.add, color: Colors.white),
              ),
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
                          "Insert age here",
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
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.amberAccent,
                    ),
                    onPressed: () async {
                      await DatabaseHelper.instance.updateUser(
                        id,
                        {'isFavorite': isFavorite ? 0 : 1},
                      );
                      _loadUsers();
                    },
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserForm(
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