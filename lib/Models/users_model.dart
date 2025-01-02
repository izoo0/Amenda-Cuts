import 'package:amenda_cuts/Common/Constants/FirebaseConstants/user_details_constants.dart';

class UsersModel {
  final String? name;
  final String? email;
  final String? number;
  final String? profile;
  final String? username;
  final String? role;

  UsersModel({
    this.name,
    this.email,
    this.number,
    this.profile,
    this.username,
    this.role,
  });
  @override
  String toString() =>
      'UsersModel(name: $name,email: $email,number: $number,profile:$profile, username: $username,role: $role)';
  factory UsersModel.fromFirebase(Map<String, dynamic> userData) {
    return UsersModel(
      name: userData[UserDetailsConstants.fullName] ?? '',
      email: userData[UserDetailsConstants.email] ?? '',
      number: userData[UserDetailsConstants.phoneNumber] ?? '',
      profile: userData[UserDetailsConstants.profilePicture] ?? '',
      username: userData[UserDetailsConstants.username] ?? '',
      role: userData[UserDetailsConstants.role] ?? '',
    );
  }
}
