class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? imageUrl;

  UserModel({required this.uid, required this.name, required this.email,required this.imageUrl});
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(uid: map['uid'], name: map['name'], email: map['email'],imageUrl: map['imageUrl']);
  }
}

late UserModel user;
