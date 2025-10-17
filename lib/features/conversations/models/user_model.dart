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
    required this.profileUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      profileUrl: map['profileUrl'],
    );
  }

  
}
late UserModel userModel;
