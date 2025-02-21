import 'package:amenda_cuts/Common/Constants/FirebaseConstants/user_details_constants.dart';

class UsersModel {
  final String? name;
  final String? email;
  final String? number;
  final String? profile;
  final String? username;
  final String? role;
  final bool? isExpert;
  final String? userId;
  UsersModel(
      {this.name,
      this.email,
      this.number,
      this.profile,
      this.username,
      this.role,
      this.userId,
      this.isExpert});

  factory UsersModel.fromFirebase(
      Map<String, dynamic> userData, String userId) {
    return UsersModel(
      userId: userId,
      name: userData[UserDetailsConstants.fullName] ?? '',
      email: userData[UserDetailsConstants.email] ?? '',
      number: userData[UserDetailsConstants.phoneNumber] ?? '',
      profile: userData[UserDetailsConstants.profilePicture] ?? '',
      username: userData[UserDetailsConstants.username] ?? '',
      role: userData[UserDetailsConstants.role] ?? '',
      isExpert: userData[UserDetailsConstants.isExpert] ?? false,
    );
  }
}
