class MessageModel {
  final String id;
  final String messageContent;
  final String senderId;
  final String senderName;
  final String senderEmail;
  final String recieverId;
  final String recieverName;
  final String recieverEmail;
  final String time;

  MessageModel({
    required this.id,
    required this.messageContent,
    required this.senderId,
    required this.senderName,
    required this.senderEmail,
    required this.recieverId,
    required this.recieverName,
    required this.recieverEmail,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'messageContent': messageContent,
      'senderId': senderId,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'recieverName': recieverName,
      'recieverEmail': recieverEmail,
      'time': time,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      messageContent: map['messageContent'],
      senderId: map['senderId'],
      senderName: map['senderName'],
      senderEmail: map['senderEmail'],
      recieverId: map['recieverId'],
      recieverName: map['recieverName'],
      recieverEmail: map['recieverEmail'],
      time: map['time'],
    );
  }
}
