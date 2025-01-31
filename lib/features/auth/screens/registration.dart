import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vendoora_mart/features/auth/domain/models/user_model.dart';
import 'package:vendoora_mart/helper/enum.dart';
import 'package:vendoora_mart/helper/helper_functions.dart';
import 'package:vendoora_mart/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isUser = true;
  bool isVendor = false;
  File? _image;
  File? _shopImage;
  File? _logoImage;

  // Controllers for text fields
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();

  // For Dropdown Button (Tag Registration)
  String? _selectedTax;
  final List<String> _taxOptions = ['Yes', 'No'];

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      UserType userType = isVendor ? UserType.vendor : UserType.customer;

      UserModel user = UserModel(
        fullName: isVendor ? null : _fullnameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneController.text,
        business: isVendor ? _businessNameController.text : null,
        address: _addressController.text,
        city: _cityController.text,
        gstNumber: isVendor ? _gstNumberController.text : null,
        // imageUrl: _image!.path.toString(),
        textRegistered: isVendor ? _selectedTax : null,
        userType: userType.value,
        // logoUrl: isVendor ? _logoImage!.path.toString() : null,
        // shopImageUrl: isVendor ? _shopImage!.path.toString() : null,
        approved: isVendor ? false : null,
      );

      AuthService.registerUserWithFirebaseAuth(context, _emailController,
          _fullnameController, _phoneController, _passwordController, user);

      // Clear form fields after registration
      _fullnameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _passwordController.clear();
    }
  }

  void onCheckBoxChange(bool? value) {
    setState(() {
      isVendor = value ?? false;
    });
    print(isVendor);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              !isVendor
                  ? Padding(
                      padding: EdgeInsets.all(40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          onTap: _imagePicker,
                          child: Container(
                            width: 200,
                            height: 200,
                            color: Colors.blue,
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Center(child: Text('Select Profile Photo')),
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        InkWell(
                          onTap: _shopImagePicker,
                          child: Container(
                            color: Colors.blue,
                            height: 240,
                            child: Center(
                                child: Text('Tap to Select Image for Shop')),
                          ),
                        ),
                        // ................................................................................LOGO
                        Padding(
                          padding: EdgeInsets.only(top: 160, left: 20),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: _logoPicker,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey.shade400,
                                    child: Center(
                                      child: Text(
                                        'Logo',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                _businessNameController.text,
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Fullname
                    isVendor
                        ? TextFormField(
                            onChanged: (value) => setState(() {}),
                            controller: _businessNameController,
                            decoration: InputDecoration(
                              labelText: 'Business Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Business Name';
                              }
                              return null;
                            },
                          )
                        : TextFormField(
                            controller: _fullnameController,
                            decoration: InputDecoration(
                              labelText: 'Fullname',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Fullname';
                              }
                              return null;
                            },
                          ),
                    SizedBox(height: 16),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Phone Number
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    isVendor
                        ? Column(
                            children: [
                              DropdownButtonFormField<String>(
                                value: _selectedTax,
                                decoration: InputDecoration(
                                  labelText: 'Tax Registered',
                                  border: OutlineInputBorder(),
                                ),
                                items: _taxOptions.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedTax = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select Option';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),

                              // GST Number
                              TextFormField(
                                controller: _gstNumberController,
                                decoration: InputDecoration(
                                  labelText: 'GST Number (Optional)',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 16),

                              // Address
                              TextFormField(
                                controller: _addressController,
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),

                              // City
                              TextFormField(
                                controller: _cityController,
                                decoration: InputDecoration(
                                  labelText: 'City',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your city';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                            ],
                          )
                        : SizedBox(),

                    // Checkbox for Vendor
                    CheckboxListTile(
                      value: isVendor,
                      onChanged: onCheckBoxChange,
                      title: Text('Are you a Vendor?'),
                    ),

                    // Register Button
                    ElevatedButton(
                      onPressed: _registerUser,
                      child: Text('Register'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _imagePicker() async {
    print('object');
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      // final XFile? pickedFile = await picker.pickImage(
      // source: ImageSource.gallery,\
      //   maxWidth: 1080,
      //   maxHeight: 1080,
      //   imageQuality: 80,
      // );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  void _logoPicker() {}

  void _shopImagePicker() {}
}
