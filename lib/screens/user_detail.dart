import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  final String? name;
  final String? email;
  final String? city;
  final String? phone;
  final String? gender;
  final String? dob;
  final List<String>? hobbies;
  final int? age;

  UserDetail({
    super.key,
    this.name,
    this.email,
    this.city,
    this.phone,
    this.gender,
    this.dob,
    this.hobbies,
    this.age,
  });

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        backgroundColor: Colors.redAccent,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.account_circle, size: 80, color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.name ?? 'N/A',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              buildInfoCard(Icons.person, 'Name', widget.name),
              buildInfoCard(Icons.wc, 'Gender', widget.gender),
              buildInfoCard(Icons.calendar_today, 'Date of Birth', widget.dob),
              buildInfoCard(Icons.cake, 'Age', widget.age?.toString()),
              buildInfoCard(Icons.location_city, 'City', widget.city),
              buildInfoCard(Icons.email, 'Email', widget.email),
              buildInfoCard(Icons.phone, 'Phone', widget.phone),

              SizedBox(height: 20),

              // Hobbies Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hobbies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Divider(),
                      widget.hobbies != null && widget.hobbies!.isNotEmpty
                          ? Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.hobbies!.map((hobby) => Chip(label: Text(hobby))).toList(),
                      )
                          : Text('No hobbies selected.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(IconData icon, String title, String? value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.redAccent),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54)),
                  SizedBox(height: 4),
                  Text(value ?? 'N/A', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
