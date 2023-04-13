import './compLogo_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';

class EmployerRegistrationForm extends StatefulWidget {
  const EmployerRegistrationForm({Key? key}) : super(key: key);

  @override
  State<EmployerRegistrationForm> createState() =>
      _EmployerRegistrationFormState();
}

class _EmployerRegistrationFormState extends State<EmployerRegistrationForm> {
  void _onImageSelected(File image) {
    File? _image;
    setState(() {
      _image = image;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String? ownerName;
  String? companyName;
  String? _selectedItem;

  List<String> _dropdownItems = [
    'Option 1',
    'Option 2',
    'Option 3',
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'contact person Name',
                    labelStyle: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter Your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    ownerName = value;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'company Name',
                    labelStyle: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the company name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    companyName = value;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'phone number',
                    labelStyle: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //Do something when the value changes
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Company Website',
                    hintText: 'www.example.com',
                    prefixIcon: Icon(Icons.language),

                    /// border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2)),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter company website';
                    } else if (!Uri.parse(value).isAbsolute) {
                      return 'Please enter a valid website';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // save the website to your data model
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Company Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Industry Type:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.blue,
                      hintText: 'Select an option',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    validator: ((value) {
                      if (value == null) {
                        return 'please select an option';
                      }
                    }),
                    value: _selectedItem,
                    items: _dropdownItems.map((item) {
                      return DropdownMenuItem(
                        child: Text(item),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedItem = value.toString();
                      });
                    }),
                SizedBox(height: 16.0),
                Text(
                  'Company size:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.blue,
                      hintText: 'Select an option',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    validator: ((value) {
                      if (value == null) {
                        return 'please select an option';
                      }
                    }),
                    value: _selectedItem,
                    items: _dropdownItems.map((item) {
                      return DropdownMenuItem(
                        child: Text(item),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedItem = value.toString();
                      });
                    }),
                CompanyLogoPicker(onImageSelected: _onImageSelected)
              ],
            )),
      ),
    );
  }
}
