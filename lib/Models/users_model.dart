class UsersModel {
  final String name;
  final String email;
  final String number;
  final String profile;
  final String username;

  UsersModel(
      {required this.name,
      required this.email,
      required this.number,
      required this.profile,
      required this.username});
  factory UsersModel.fromFirebase(Map<String, dynamic> userData) {
    return UsersModel(
      name: userData['full_name'],
      email: userData['email'],
      number: userData['phone_number'],
      profile: userData['profile'],
      username: userData['username'],
    );
  }
}
