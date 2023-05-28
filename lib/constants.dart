import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

TextStyle boldStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 25,
);

TextStyle normalStyle = const TextStyle(
  fontSize: 18,
  color: Colors.black,
);

TextStyle smallStyle = const TextStyle(
  fontSize: 16,
  color: Colors.black,
);

TextStyle normalBoldStyle = const TextStyle(
  fontSize: 16,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

TextStyle whiteStyle = const TextStyle(color: Colors.white);

void nextPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}

void snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

String? emailvalidator(String? val) {
  if (RegExp(r'^[a-zA-Z0-9_\.\+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-\.]+')
      .hasMatch(val!)) {
    return null;
  }

  return "Enter Valid Email";
}

String? passwordValidator(String? val) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (val!.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(val)) {
      return 'Enter valid password';
    } else {
      return null;
    }
  }
}

String? mobileValidator(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

String? nameValidator(String value) {
  if (value.isEmpty) {
    return 'Please enter Name';
  }
  return null;
}

String? clgNameValidator(String value) {
  if (value.isEmpty) {
    return 'Please enter College Name';
  }
  return null;
}

String? userTypeValidator(String val) {
  if (val == 'Select your Type') {
    return 'Please select your type';
  }
  return null;
}

String? admissionYearValidator(String val) {
  if (val == 'Admission year') {
    return 'Please select your type';
  }
  return null;
}

String? passOutYearValidator(String val) {
  if (val == 'Pass out year') {
    return 'Please select your type';
  }
  return null;
}

void profilePicValidator(
    BuildContext context, String uid, String imageUrl) async {
  final navigator = ScaffoldMessenger.of(context);
  ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  print('${file?.path}');

  if (file == null) {
    navigator.showSnackBar(
        const SnackBar(content: Text('Please upload Profile image')));
  } else {
    navigator.showSnackBar(
        const SnackBar(content: Text('Image Uploaded Successfully !')));
  }

  //Get a reference to storage root
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDirImages = referenceRoot.child('images');

  //Create a reference for the image to be stored
  Reference referenceImageToUpload = referenceDirImages.child(uid);

  //Handle errors/success
  try {
    //Store the file
    await referenceImageToUpload.putFile(File(file!.path));

    imageUrl = await referenceImageToUpload.getDownloadURL();
  } catch (error) {
    //Some error occurred
    print(error);
  }
}
