import 'package:amenda_cuts/Common/Constants/FirebaseConstants/user_details_constants.dart';

class OtherUsersModel {
  final String? otherUserId;
  final String? name;
  final String? email;
  final String? number;
  final String? profile;
  final String? username;
  final String? role;
  final bool? isExpert;
  final double? rating;
  OtherUsersModel(
      {this.otherUserId,
      this.name,
      this.email,
      this.number,
      this.profile,
      this.username,
      this.role,
      this.isExpert,
      this.rating});
  @override
  String toString() =>
      'OtherUsersModel(name: $name,email: $email,number: $number,profile:$profile, username: $username,role: $role, isExpert:$isExpert)';
  factory OtherUsersModel.fromFirebase(
      Map<String, dynamic> userData, documentId) {
    return OtherUsersModel(
      otherUserId: documentId,
      name: userData[UserDetailsConstants.fullName] ?? '',
      email: userData[UserDetailsConstants.email] ?? '',
      number: userData[UserDetailsConstants.phoneNumber] ?? '',
      profile: userData[UserDetailsConstants.profilePicture] ?? '',
      username: userData[UserDetailsConstants.username] ?? '',
      role: userData[UserDetailsConstants.role] ?? '',
      isExpert: userData[UserDetailsConstants.isExpert] ?? false,
      rating: userData[UserDetailsConstants.rating] ?? 0,
    );
  }
}
