class CreateUserModel {
  final String uid;
  final String name;
  final String email;
  String? imageUrl;

  CreateUserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return{
      'uid':uid,
      'name':name,
      'email':email,
      'imageUrl':imageUrl
    };
  }
}
