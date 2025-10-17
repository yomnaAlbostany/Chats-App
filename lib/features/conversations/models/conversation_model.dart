class ConversationModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String? profileUrl;

  ConversationModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileUrl,
  });

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      profileUrl: map['profileUrl'],
    );
  }
}
