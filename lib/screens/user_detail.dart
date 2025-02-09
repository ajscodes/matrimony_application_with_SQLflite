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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _selectedGender;
  String? _selectedCity;
  List<String> _hobbies = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name ?? 'N/A';
    _emailController.text = widget.email ?? 'N/A';
    _phoneController.text = widget.phone ?? 'N/A';
    _dobController.text = widget.dob ?? 'N/A';
    _selectedGender = widget.gender ?? 'N/A';
    _selectedCity = widget.city ?? 'N/A';
    _hobbies = widget.hobbies ?? [];
    _ageController.text = widget.age != null ? widget.age.toString() : 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 100,
                    ),
                    Text(
                      _nameController.text,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Section: About
              sectionTitle('About'),
              infoTile('Name', _nameController.text),
              infoTile('Gender', _selectedGender!),
              infoTile('Date of Birth', _dobController.text),
              infoTile('Age', _ageController.text),

              SizedBox(height: 20),

              // Section: Location
              sectionTitle('Location'),
              infoTile('Country', 'India'),
              infoTile('City', _selectedCity!),

              SizedBox(height: 20),

              // Section: Professional Details
              sectionTitle('Professional Details'),
              infoTile('Higher Education', 'B.Sc (Hons) CS'),
              infoTile('Occupation', 'Software Engineer'),

              SizedBox(height: 20),

              // Section: Contact Details
              sectionTitle('Contact Details'),
              infoTile('Email ID', _emailController.text),
              infoTile('Phone', _phoneController.text),

              SizedBox(height: 20),

              // Section: Hobbies
              sectionTitle('Hobbies'),
              _hobbies.isNotEmpty
                  ? Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _hobbies
                    .map((hobby) => Chip(label: Text(hobby)))
                    .toList(),
              )
                  : Text('No hobbies selected.', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Divider(),
      ],
    );
  }

  Widget infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
