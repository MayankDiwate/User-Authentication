enum USERTYPE { student, faculty, alumni }

class UserModel {
  final String? id;
  final String userType;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String collegeName;
  final String? admissionYear;
  final String? passOutYear;
  // final String profilePic;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.userType,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.collegeName,
    this.passOutYear,
    this.admissionYear,
    // required this.profilePic,
  });

  toJson() {
    return {
      "Image Id": id,
      "User Type": userType,
      "FullName": fullName,
      "Email": email,
      "Phone No": phoneNo,
      "Password": password,
      "College Name": collegeName,
      "Admission Year": admissionYear,
      "Pass Out Year": passOutYear,
      // "Profile Pic": profilePic,
    };
  }
}
