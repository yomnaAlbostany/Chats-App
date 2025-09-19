class MessageModel {
  final String id;
  final String message;
  final String senderId;
  final String senderName;
  final String senderEmail;
  final String recieverId;
  final String recieverName;
  final String recieverEmail;
  final String time;

  MessageModel(
    this.id,
    this.message,
    this.senderId,
    this.senderName,
    this.senderEmail,
    this.recieverId,
    this.recieverName,
    this.recieverEmail,
    this.time
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'senderId': senderId,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'recieverName': recieverName,
      'recieverEmail': recieverEmail,
      'time':time
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      map['id'],
      map['message'],
      map['senderId'],
      map['senderName'],
      map['senderEmail'],
      map['recieverId'],
      map['recieverName'],
      map['recieverEmail'],
      map['time']
    );
  }
}
