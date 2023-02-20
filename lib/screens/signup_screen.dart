import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:user_auth/controllers/auth_controller.dart';
import 'package:user_auth/models/user_model.dart';
import 'package:user_auth/screens/login_screen.dart';
import 'package:uuid/uuid.dart';

import '../apis/firebase_api.dart';
import '../constants.dart';
import '../widgets/textformfield_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _clgNameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  late String dropdownvalue;
  late String year = 'Admission year';
  late String passOutYr = 'Pass out year';
  late Image profilePic = Image.asset('assets/logo.png');
  late String imageUrl = '';
  String uuid = const Uuid().v1();
  File? file;
  UploadTask? task;

  final FirebaseAuth auth = FirebaseAuth.instance;
  // final String uniqueId = AuthController.instance.auth.currentUser!.uid;

  // final CollectionReference _reference =
  //     FirebaseFirestore.instance.collection('collection');

  var passoutyears = ['Pass out year', '2015', '2016', '2017', '2018', 'so on'];
  var years = [
    'Admission year',
    '2020',
    '2021',
    '2022',
    '2023',
    'so on',
  ];
  var items = ['Select your Type', 'Student', 'Faculty', 'Alumni'];

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _clgNameController = TextEditingController();
    dropdownvalue = 'Select your Type';
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _clgNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Welcome Back !', style: boldStyle)),
                const SizedBox(height: 10),

                // User Type
                Row(
                  children: [
                    Text('User Type :- ', style: normalStyle),
                    const SizedBox(width: 50),
                    SizedBox(
                      width: size.width * 0.45,
                      child: DropdownButtonFormField<String>(
                        validator: (value) => userTypeValidator(dropdownvalue),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: dropdownvalue,
                        items: items.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: normalStyle),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            dropdownvalue = val!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Upload Profile Pic
                Row(
                  children: [
                    Text('Profile Pic :- ', style: normalStyle),
                    const SizedBox(width: 40),
                    ElevatedButton.icon(
                      onPressed: () =>
                          profilePicValidator(context, uuid, imageUrl),
                      icon: const Icon(Icons.upload),
                      label: const Text(
                        'Upload profile pic',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                //Name Field
                Text('Name', style: normalStyle),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  validate: (val) => nameValidator(val!),
                  hintText: 'Name',
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),

                // Email Field
                Text('Email', style: normalStyle),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  validate: (val) => emailvalidator(val),
                  hintText: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.mail),
                ),
                const SizedBox(height: 10),

                // Password Field
                Text('Password', style: normalStyle),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  sufficIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: isVisible
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.remove_red_eye_outlined),
                  ),
                  validate: (val) => passwordValidator(val),
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  prefixIcon: const Icon(Icons.key),
                  hintText: 'Password',
                  obscureText: isVisible,
                ),
                const SizedBox(height: 10),

                // Phone Number Field
                Text('Phone Number', style: normalStyle),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  validate: (val) => mobileValidator(val!),
                  prefixIcon: const Icon(Icons.phone),
                  controller: _phoneController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  length: 10,
                ),
                const SizedBox(height: 10),

                // College Name
                Text('College Name', style: normalStyle),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  validate: (val) => clgNameValidator(val!),
                  prefixIcon: const Icon(Icons.phone),
                  controller: _clgNameController,
                  hintText: 'College Name',
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 10),

                // Upload Resume
                Row(
                  children: [
                    Text('Resume :- \n(optional)', style: normalStyle),
                    const SizedBox(width: 50),
                    ElevatedButton.icon(
                      onPressed: () => selectAndUploadFile(),
                      icon: const Icon(Icons.upload),
                      label: const Text(
                        'Upload resume',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Conditional Data
                if (dropdownvalue == 'Student') ...[
                  // Admission year
                  Row(
                    children: [
                      Text('Adimssion Year :- ', style: normalStyle),
                      const SizedBox(width: 30),
                      SizedBox(
                        width: size.width * 0.4,
                        child: DropdownButtonFormField<String>(
                          validator: (val) => admissionYearValidator(val!),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: year,
                          items: years.map((String yr) {
                            return DropdownMenuItem<String>(
                              value: yr,
                              child: Text(yr, style: normalStyle),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              year = val!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                if (dropdownvalue == "Alumni") ...[
                  // Pass Out Year
                  Row(
                    children: [
                      Text('Pass Out Year :- ', style: normalStyle),
                      const SizedBox(width: 30),
                      SizedBox(
                        width: size.width * 0.45,
                        child: DropdownButtonFormField<String>(
                          validator: (val) => passOutYearValidator(val!),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: passOutYr,
                          items: passoutyears.map((String passOut) {
                            return DropdownMenuItem<String>(
                              value: passOut,
                              child: Text(passOut, style: normalStyle),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              passOutYr = val!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 20),
                // Signup Button
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 20)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 40)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthController.instance.register(
                            _emailController.text.trim(),
                            _passwordController.text.trim());

                        // Student Data Model
                        final student = UserModel(
                          id: uuid,
                          userType: dropdownvalue,
                          fullName: _nameController.text,
                          email: _emailController.text,
                          phoneNo: _phoneController.text,
                          password: _passwordController.text,
                          collegeName: _clgNameController.text,
                          admissionYear: year,
                        );

                        // Faculty Data Model
                        final faculty = UserModel(
                          id: uuid,
                          userType: dropdownvalue,
                          fullName: _nameController.text,
                          email: _emailController.text,
                          phoneNo: _phoneController.text,
                          password: _passwordController.text,
                          collegeName: _clgNameController.text,
                        );

                        // Alumni Data Model
                        final alumni = UserModel(
                          id: uuid,
                          userType: dropdownvalue,
                          fullName: _nameController.text,
                          email: _emailController.text,
                          phoneNo: _phoneController.text,
                          password: _passwordController.text,
                          collegeName: _clgNameController.text,
                          passOutYear: passOutYr,
                        );

                        switch (dropdownvalue) {
                          case "Student":
                            AuthController.instance.createUser(student);
                            break;
                          case "Faculty":
                            AuthController.instance.createUser(faculty);
                            break;
                          case "Alumni":
                            AuthController.instance.createUser(alumni);
                            break;
                          default:
                            null;
                            break;
                        }
                      }
                      print("Image Url :- $imageUrl");
                    },
                    child: const Text('Sign Up'),
                  ),
                ),
                const SizedBox(height: 10),

                // Login if already have an account
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: smallStyle,
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: normalBoldStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => nextPage(context, const LoginScreen()),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectAndUploadFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    var path = result.files.single.path!;

    setState(() => file = File(path));
    print("Path = $path");
    print("Length = ${path.length}");

    print('After Path = $path');

    if (file == null) return;

    String fileName = (file!.path).substring(53, path.length);

    print('File Name = $fileName');
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  // Future uploadFile() async {
  //   if (file == null) return;

  //   final fileName = (file!.path);
  //   final destination = 'files/$fileName';

  //   task = FirebaseApi.uploadFile(destination, file!);
  //   setState(() {});

  //   if (task == null) return;

  //   final snapshot = await task!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();

  //   print('Download-Link: $urlDownload');
  // }
}
