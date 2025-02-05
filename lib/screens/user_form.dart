import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  final String? name;
  final String? email;
  final String? password;
  final String? city;
  final String? phone;
  final String? gender;
  final String? dob;
  final List<String>? hobbies;

  const UserForm(
      {super.key,
      this.name,
      this.email,
      this.password,
      this.city,
      this.phone,
      this.gender,
      this.dob,
      this.hobbies});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String ? _selectedGender;
  String ? _selectedCity;
  List<String> _hobbies = [];

  final List<String> cities = ['Rajkot','Jamnagar','Ahmedabad','Vadodara'];
  final List<String> hobbiesOptions = ['Reading','Travelling','Sports','Coding'];

  @override
  void initState(){
    super.initState();
    _nameController.text = widget.name ?? '';
    _emailController.text = widget.email ?? '';
    _passwordController.text = widget.password ?? '';
    _phoneController.text = widget.phone ?? '';
    _dobController.text = widget.dob ?? '';
    _selectedGender = widget.gender;
    _selectedCity = widget.city;
    _hobbies = widget.hobbies ?? [];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: _nameController.text == ''
            ? Text(
                'Add User',
                style: TextStyle(color: Colors.white),
              )
            : Text(
                'Update User',
                style: TextStyle(color: Colors.white),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(key: _formkey, 
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Enter your name',
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value){
                      if(value == null || value.isEmpty ||
                      !RegExp(r"^[a-zA-Z\s']{3,50}$").hasMatch(value)){
                        return 'Please Enter valid full name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Enter your email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if (value == null || value.isEmpty ||
                          !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
