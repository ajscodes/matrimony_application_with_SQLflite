import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String? _selectedGender;
  String? _selectedCity;
  DateTime? _selectedDate;
  List<String> _hobbies = [];

  final List<String> cities = [
    'Ahmedabad',
    'Surat',
    'Vadodara',
    'Rajkot',
    'Bhavnagar',
    'Jamnagar',
    'Gandhinagar',
    'Junagadh',
    'Anand',
    'Navsari',
    'Morbi',
    'Nadiad',
    'Surendranagar',
    'Bharuch',
    'Mehsana',
    'Bhuj',
    'Valsad',
    'Gondal',
    'Veraval',
    'Patan',
    'Porbandar',
    'Godhra',
    'Botad',
    'Amreli',
    'Dahod',
    'Palanpur',
    'Deesa',
    'Jetpur',
    'Ankleshwar',
    'Wadhwan',
    'Gandhidham',
    'Vyara',
    'Chhota Udepur',
    'Modasa',
    'Mahesana',
    'Kalol',
    'Umreth',
    'Visnagar',
    'Sanand',
    'Himmatnagar'
  ];
  final List<String> hobbiesOptions = [
    'Reading',
    'Travelling',
    'Sports',
    'Coding'
  ];

  @override
  void initState() {
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
        iconTheme: IconThemeData(color: Colors.white),
        title: _nameController.text == ''
            ? Text(
                'Add User',
                style: TextStyle(color: Colors.white),
              )
            : Text(
                'Update User',
                style: TextStyle(color: Colors.white),
              ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Full Name
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: Colors.redAccent,
                          prefixIconConstraints: BoxConstraints(minWidth: 60),
                          hintText: 'Enter your name',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.redAccent), // Soft grey border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.redAccent, width: 2), // Highlighted in redAccent when focused
                          ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r"^[a-zA-Z\s']{3,50}$").hasMatch(value)) {
                          return 'Please Enter valid full name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //Email
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.redAccent,
                          prefixIconConstraints: BoxConstraints(minWidth: 60),
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          hintText: 'Enter your email',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.redAccent), // Soft grey border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.redAccent, width: 2), // Highlighted in redAccent when focused
                          ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //Mobile number
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          prefixIconColor: Colors.redAccent,
                          prefixIconConstraints: BoxConstraints(minWidth: 60),
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          hintText: 'Enter mobile number',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.redAccent), // Soft grey border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.redAccent, width: 2), // Highlighted in redAccent when focused
                          ),
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      validator: (value) {
                        if (value == null ||
                            value.length != 10 ||
                            !RegExp(r'^\+?1?\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    //Date of Birth
                    TextFormField(
                      controller: _dobController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.date_range),
                        prefixIconColor: Colors.redAccent,
                        prefixIconConstraints: BoxConstraints(minWidth: 60),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: 'Enter Date of Birth',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.redAccent), // Soft grey border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.redAccent, width: 2), // Highlighted in redAccent when focused
                        ),
                      ),
                      readOnly: true, // Prevents keyboard from opening
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date of birth must not be empty.';
                        }
                        try {
                          DateTime dob = DateFormat('dd/MM/yyyy').parse(value);
                          int age = DateTime.now().year - dob.year;
                          if (DateTime.now().month < dob.month ||
                              (DateTime.now().month == dob.month && DateTime.now().day < dob.day)) {
                            age--;
                          }
                          if (age < 18) {
                            return 'You must be at least 18 years old to register.';
                          }
                        } catch (e) {
                          return 'Invalid date format. Use DD/MM/YYYY.';
                        }
                        return null;
                      },
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode()); // Prevent keyboard from appearing
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime(1995),
                          firstDate: DateTime(1960),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            _selectedDate = pickedDate;
                            _dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10,),

                    //City
                    DropdownButtonFormField2(
                      value: _selectedCity,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_city_outlined),
                            prefixIconColor: Colors.redAccent,
                            prefixIconConstraints: BoxConstraints(minWidth: 60),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.redAccent), // Soft grey border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.redAccent, width: 2), // Highlighted in redAccent when focused
                            ),
                        ),
                        hint: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Select City", style: TextStyle(color: Colors.grey[600])),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          )
                        ),
                        items: cities.map((city) => DropdownMenuItem(value: city,
                            child: Text(city),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCity = value;
                            print(':::$_selectedCity');
                          });
                        },
                      validator: (value){
                        if(value == null){
                          return 'Please select city';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
