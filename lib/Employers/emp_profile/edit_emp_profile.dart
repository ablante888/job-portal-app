import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:project1/Employers/bridgeTOemp_home_page.dart';
import 'package:project1/Employers/home_page/tabs_screen.dart';
import 'package:project1/Employers/models/jobs_model.dart';
import './compLogo_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';
import '../Employers_account/empUtils.dart';

class EditEmployerProfile extends StatefulWidget {
  static const routeName = '/EditEmployerProfile';
  const EditEmployerProfile({Key? key}) : super(key: key);

  @override
  State<EditEmployerProfile> createState() => _EditEmployerProfileState();
}

class _EditEmployerProfileState extends State<EditEmployerProfile> {
  File? _image;
  void _onImageSelected(File image) {
    setState(() {
      _image = image;
      //  companyLogo = url;
    });
  }

  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void printImagePath() {
    print('your image path is : ${_image}');
  }

  Future saveEmployerInfo(Company companyInfonfo) async {
    final emp_document_ref = FirebaseFirestore.instance
        .collection('employer')
        .doc(getCurrentUserUid());
    final emp_profile_ref =
        emp_document_ref.collection('company profile').doc('profile');
    _companyId = emp_document_ref.id;
    final json = companyInfonfo.toJson();
    await emp_profile_ref
        // .collection('Employer profile')
        // .doc('personal_info')
        .set(json);
  }

  String? _uploadedFileURL;

  Future<void> _uploadFile() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference reference =
        storage.ref().child('images/Employers/$fileName');
    final UploadTask uploadTask = reference.putFile(_image!);
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = (await downloadUrl.ref.getDownloadURL());
    setState(() {
      _uploadedFileURL = url;
      companyLogo = url;
    });
    print('the company logo url is : ${companyLogo}');
  }

  final contactPersonConteroller = TextEditingController();
  final companyNameController = TextEditingController();
  final streetAdressConteroller = TextEditingController();
  final cityController = TextEditingController();
  final regionController = TextEditingController();
  final countryController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final descreptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _companyId = '';
  String contactPerson = '';
  String _streetAddress = '';
  String _city = '';
  String _state = '';
  String _country = '';
  String _zipCode = '';
  String companyName = '';
  String phoneNumber = '';
  String email = '';
  String companyWebsite = '';
  String comapnyDesription = '';
  String _IndustryTypeselected = '';
  String companySzeSelected = '';
  String? companyLogo;

  List<String> _dropdownItems = [
    'Option 1',
    'Option 2',
    'Option 3',
  ];
  @override
  Widget build(BuildContext context) {
    // printImagePath();
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('employer')
                .doc(getCurrentUserUid())
                .collection('company profile')
                .doc('profile')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Text('No data available');
              }
              Map<String, dynamic>? profileData = snapshot.data!.data();
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Update Company Information',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextFormField(
                            controller: contactPersonConteroller
                              ..text = profileData?['email'] ?? 'name',
                            decoration: InputDecoration(
                              labelText: 'contact person Name',
                              labelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter contact person name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) contactPerson = value;
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextFormField(
                            controller: companyNameController
                              ..text = profileData?['name'] ?? 'name',
                            decoration: InputDecoration(
                              labelText: 'company Name',
                              labelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
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
                              if (value != null) companyName = value;
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextFormField(
                            controller: streetAdressConteroller
                              ..text = profileData?['address'] ?? 'name',
                            decoration: InputDecoration(
                              labelText: 'Street Address',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w700,
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a street address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) _streetAddress = value;
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextFormField(
                            controller: cityController
                              ..text = profileData?['city'] ?? 'name',
                            decoration: InputDecoration(
                              labelText: 'City',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w700,
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a city';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) _city = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextFormField(
                            controller: regionController
                              ..text = profileData?['state'] ?? 'name',
                            decoration: InputDecoration(
                              labelText: 'State/Region',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w700,
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a state';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) _state = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextFormField(
                            controller: countryController
                              ..text = profileData?['country'] ?? 'name',
                            decoration: InputDecoration(
                              labelText: 'Country',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w700,
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a state';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) _state = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextFormField(
                            controller: phoneController
                              ..text = profileData?['phone'] ?? 'name',
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'phone number',
                              labelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
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
                            onSaved: (newValue) {
                              if (newValue != null) phoneNumber = newValue;
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextFormField(
                            controller: emailController
                              ..text = profileData?['email'] ?? 'name',
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email address',
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.blue[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
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
                            onSaved: (newValue) {
                              if (newValue != null) email = newValue;
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextFormField(
                            controller: websiteController
                              ..text = profileData?['website'] ?? 'name',
                            decoration: InputDecoration(
                              labelText: 'Company Website',
                              hintText: 'www.example.com',
                              prefixIcon: Icon(Icons.language),

                              /// border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.blue[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2)),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            keyboardType: TextInputType.url,
                            // validator: (value) {
                            //   if (value == null) {
                            //     return 'Please enter company website';
                            //   } else if (!Uri.parse(value).isAbsolute) {
                            //     return 'Please enter a valid website';
                            //   }
                            //   return null;
                            // },
                            onSaved: (newValue) {
                              if (newValue != null) companyWebsite = newValue;
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextFormField(
                            controller: descreptionController
                              ..text = profileData?['email'] ?? 'name',
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: 'Company Description',
                              filled: true,
                              fillColor: Colors.blue[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
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
                            onSaved: (newValue) {
                              if (newValue != null)
                                comapnyDesription = newValue;
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Industry Type:',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                                hintText: 'Select an option',
                                // hintStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              validator: ((value) {
                                if (value == null) {
                                  return 'please select an option';
                                }
                              }),
                              value:
                                  profileData?['industry'] ?? 'endustry type',
                              items: _dropdownItems.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _IndustryTypeselected = value.toString();
                                });
                              }),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Company size:',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                filled: true,
                                fillColor: Colors.blue[50],
                                hintText: 'Select an option',
                                // hintStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              validator: ((value) {
                                if (value == null) {
                                  return 'please select an option';
                                }
                              }),
                              value: profileData?['company-size'] ??
                                  'company size',
                              items: _dropdownItems.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  companySzeSelected = value.toString();
                                });
                              }),
                        ),
                        // CompanyLogoPicker(onImageSelected: _onImageSelected),
                        Text(
                          'Profile Picture:',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        CompanyLogoPicker(onImageSelected: _onImageSelected),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size.fromHeight(50)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.arrow_back),
                                  label: Text('Back')),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size.fromHeight(50)),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState?.save();
                                      _uploadFile();
                                      final companyInfo = Company(
                                          companyId: _companyId,
                                          name: companyName,
                                          address: _streetAddress,
                                          city: _city,
                                          state: _state,
                                          country: _country,
                                          phone: phoneNumber,
                                          email: email,
                                          website: companyWebsite,
                                          description: comapnyDesription,
                                          industry: _IndustryTypeselected,
                                          companySize: companySzeSelected,
                                          logoUrl: companyLogo as String);
                                      try {
                                        saveEmployerInfo(companyInfo);

                                        EmpUtils.showSnackBar(
                                            'sucessfully saved', Colors.green);
                                      } on FirebaseException catch (e) {
                                        EmpUtils.showSnackBar(
                                            e.message, Colors.red);
                                      }
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   TabsScreen.routeName,
                                      // );
                                      Navigator.pushNamed(
                                          context, TabsScreen.routeName,
                                          arguments: companyInfo);
                                    }
                                  },
                                  icon: Icon(Icons.arrow_forward),
                                  label: Text('Update')),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
              );
            }),
      ),
    );
  }
}
