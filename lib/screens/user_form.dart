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
  final List<Map<String, dynamic>>? hobbies;

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
  List<String> selectedHobbies = [];

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
  final List<Map<String, dynamic>> hobbiesOptions = [
    {"name": "Reading & Writing", "icon": Icons.menu_book},
    {"name": "Traveling", "icon": Icons.flight},
    {"name": "Cooking & Food", "icon": Icons.restaurant},
    {"name": "Fitness & Yoga", "icon": Icons.fitness_center},
    {"name": "Music & Dance", "icon": Icons.music_note},
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
    selectedHobbies = widget.hobbies?.map((hobby) => hobby["name"] as String).toList() ?? [];

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
                        prefixIcon: Icon(Icons.person_outline),
                        prefixIconColor: Colors.grey[600],
                        prefixIconConstraints: BoxConstraints(minWidth: 60),
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.grey[400]!), // Soft grey border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.redAccent.shade200,
                              width: 2), // Highlighted in redAccent when focused
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
                        prefixIcon: Icon(Icons.alternate_email),
                        prefixIconColor: Colors.grey[600],
                        prefixIconConstraints: BoxConstraints(minWidth: 60),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: 'Enter your email',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.grey[400]!), // Soft grey border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.redAccent.shade200,
                              width:
                                  2), // Highlighted in redAccent when focused
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
                        prefixIcon: Icon(Icons.phone_iphone),
                        prefixIconColor: Colors.grey[600],
                        prefixIconConstraints: BoxConstraints(minWidth: 60),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: 'Enter mobile number',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.grey[400]!), // Soft grey border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.redAccent.shade200,
                              width:
                                  2), // Highlighted in redAccent when focused
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
                        prefixIcon: Icon(Icons.event),
                        prefixIconColor: Colors.grey[600],
                        prefixIconConstraints: BoxConstraints(minWidth: 60),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: 'Enter Date of Birth',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.grey[400]!), // Soft grey border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.redAccent.shade200,
                              width:
                                  2), // Highlighted in redAccent when focused
                        ),
                      ),
                      readOnly: true,
                      // Prevents keyboard from opening
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date of birth must not be empty.';
                        }
                        try {
                          DateTime dob = DateFormat('dd/MM/yyyy').parse(value);
                          int age = DateTime.now().year - dob.year;
                          if (DateTime.now().month < dob.month ||
                              (DateTime.now().month == dob.month &&
                                  DateTime.now().day < dob.day)) {
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
                        FocusScope.of(context).requestFocus(
                            FocusNode()); // Prevent keyboard from appearing
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime(1995),
                          firstDate: DateTime(1960),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            _selectedDate = pickedDate;
                            _dobController.text =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //City
                    DropdownButtonFormField2(
                      value: _selectedCity,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.place),
                        prefixIconColor: Colors.grey[600],
                        prefixIconConstraints: BoxConstraints(minWidth: 60),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.grey[400]!), // Soft grey border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.redAccent.shade200,
                              width:
                                  2), // Highlighted in redAccent when focused
                        ),
                      ),
                      hint: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Select City",
                            style: TextStyle(color: Colors.grey[600])),
                      ),
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          )),
                      items: cities
                          .map((city) => DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCity = value;
                          print(':::$_selectedCity');
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select city';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //Gender
                    Card(
                      color: Colors.white,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10), // Added padding for better spacing
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align text properly
                          children: [
                            Center( // Centers the title
                              child: Text(
                                'Select Gender',
                                style: TextStyle(fontSize: 18, color: Colors.black,),
                              ),
                            ),
                            Divider(thickness: 1.2, color: Colors.grey[400]),

                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10, // Space between elements
                              children: [
                                // Male Option
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio<String>(
                                      value: "Male",
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value;
                                        });
                                      },
                                    ),
                                    Icon(Icons.male, color: Colors.blueAccent[400]),
                                    SizedBox(width: 4),
                                    Text("Male"),
                                  ],
                                ),

                                // Female Option
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio<String>(
                                      value: "Female",
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value;
                                        });
                                      },
                                    ),
                                    Icon(Icons.female, color: Colors.pinkAccent[400]),
                                    SizedBox(width: 4),
                                    Text("Female"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    //Hobby
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey[400]!),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Center(
                                  child: Text(
                                    "Select Hobbies",
                                    style: TextStyle(
                                      fontSize: 18.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),

                                // Divider
                                Divider(
                                  thickness: 1.2,
                                  color: Colors.grey[400], // Matching your theme
                                ),

                                // Hobbies Toggle Chips
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: hobbiesOptions.map((hobby) {
                                    bool isSelected = selectedHobbies.contains(hobby["name"]);
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            selectedHobbies.remove(hobby["name"]);
                                          } else {
                                            selectedHobbies.add(hobby["name"]);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: isSelected ? Colors.redAccent : Colors.grey[100],
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: isSelected ? Colors.redAccent : Colors.grey[400]!,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              hobby["icon"], // Ensure this is a valid icon reference
                                              size: 20,
                                              color: isSelected ? Colors.white : Colors.grey[700],
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              hobby["name"],
                                              style: TextStyle(
                                                color: isSelected ? Colors.white : Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),

                                // Space before showing selected hobbies
                                SizedBox(height: 10),

                                // Selected hobbies text
                                Divider(thickness: 1, color: Colors.grey[300]),
                                Center(
                                  child: Text(
                                    "Selected: ${selectedHobbies.isNotEmpty ? selectedHobbies.join(', ') : 'None'}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              )),
        ),
      ),
    );
  }
}
