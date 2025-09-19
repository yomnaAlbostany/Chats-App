class ConversationModel {
  final String uid;
  final String name;
  final String? imageUrl;
  final String email;

  ConversationModel( {
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl

  });

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      imageUrl: map['imageUrl']
    );
  }
}
