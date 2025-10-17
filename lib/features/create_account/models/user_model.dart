class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String? profileUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.profileUrl,
  });

  toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'profileUrl': profileUrl,
    };
  }
}
