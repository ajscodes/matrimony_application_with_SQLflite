import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_application/screens/user_detail.dart';
import 'package:matrimony_application/screens/user_form.dart';
import 'package:matrimony_application/utils/database_helper.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

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
    //_searchController.addListener(_filterUsers);
  }

  Future<void> _loadUsers() async {
    try {
      final users = await DatabaseHelper.instance.getUsers();
      print('Fetched users: $users');
      setState(() {
        user_List = users.map((user) {
          // Create a new map with the updated 'age' and decoded 'hobbies'
          final newUser = Map<String, dynamic>.from(user);
          newUser['age'] = user['dob'] != null ? _calculateAge(user['dob']) : 0;

          // Decode the hobbies JSON string
          try {
            newUser['hobbies'] = (jsonDecode(user['hobbies'] as String) as List<dynamic>).cast<String>();
            print('Decoded hobbies: ${newUser['hobbies']}'); // Add this line
            print('Type of hobbies: ${newUser['hobbies'].runtimeType}'); // Add this line
          } catch (e) {
            print('Error decoding hobbies: $e');
            newUser['hobbies'] = []; // Default to an empty list in case of error
          }

          return newUser;
        }).toList();
        _filteredUsers = List.from(user_List);
        print('User List: $user_List');
        print('Filtered Users: $_filteredUsers');
      });
    } catch (e) {
      print('Error loading users: $e');
    }
  }

  int _calculateAge(String dob) {
    DateTime birthDate = DateFormat('dd/MM/yyyy').parse(dob);
    int age = DateTime.now().year - birthDate.year;
    if (DateTime.now().month < birthDate.month ||
        (DateTime.now().month == birthDate.month && DateTime.now().day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void _filterUsers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = user_List
          .where((user) =>
      user['name'].toLowerCase().contains(query) ||
          user['email'].toLowerCase().contains(query) ||
          user['city'].toLowerCase().contains(query))
          .map((user) => {
        ...user,
        'age': user['age'],
        'hobbies': user['hobbies'],
      })
          .toList();
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, int userId) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          'Confirm Delete',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Are you sure you want to delete this user?',
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
              _deleteUser(userId); // Perform the delete action
            },
          ),
        ],
      ),
    );
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
            child: Row(
              children: [
                Expanded(
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
                    onChanged: (value) => _filterUsers(), // Calls filter function on input
                  ),
                ),
                SizedBox(width: 8),
                // Sorting Button
                PopupMenuButton<String>(
                  //onSelected: _sortUsers,
                  icon: Icon(Icons.sort, color: Colors.redAccent),
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'A-Z', child: Text('Name(A-Z)')),
                    PopupMenuItem(value: 'Z-A', child: Text('Name(Z-A)')),
                    PopupMenuItem(value: 'Young-Old', child: Text('Age(18-65)')),
                    PopupMenuItem(value: 'Old-Young', child: Text('Age(65-18)')),
                  ],
                ),
              ],
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
                    key: UniqueKey(),
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
                        _filteredUsers[index]['age'],  // Pass age here
                        _filteredUsers[index]['city'],
                        _filteredUsers[index]['hobbies'], // Make sure this is a List<String>
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
                        Navigator.pushNamed(context, '/adduser').then((value) {
                          if (value == true) {
                            _loadUsers(); // Refresh the list
                          }
                        });
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

  Widget listCard(int index, int id, String name, String email, String phone,
      String gender, String dob, int age, String city,
      List<String> hobbies, bool isFavorite) {
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
                name: name,
                email: email,
                gender: gender,
                dob: dob,
                age: age, // Pass age here
                phone: phone,
                city: city,
                hobbies: hobbies,
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
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        gender.toLowerCase() == 'male'
                            ? Icon(Icons.male, color: Colors.blueAccent)
                            : Icon(Icons.female, color: Colors.pinkAccent),
                        const SizedBox(width: 4),
                        Text(
                          "$age years", // Display age
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
                  // Favorite Toggle Button
                  IconButton(
                    icon: Icon(
                      size: 25,
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.amberAccent,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        // Show confirmation dialog before removing from favorites
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

                  // Popup Menu for Edit & Delete
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        // Navigate to Edit Form
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserForm(
                              id: id,
                              name: name,
                              email: email,
                              phone: phone,
                              gender: gender,
                              dob: dob,
                              age: age, // Pass age here
                              city: city,
                              hobbies: hobbies,
                            ),
                          ),
                        ).then((value) {
                          if (value != null) _loadUsers();
                        });
                      } else if (value == 'delete') {
                        // Show delete confirmation dialog
                        _showDeleteConfirmationDialog(context, id);
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