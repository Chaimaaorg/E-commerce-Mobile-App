class Message{
  String text;
  bool isSentMe;
  DateTime date;
  Message({required this.text, required this.isSentMe, required this.date});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isSentMe': isSentMe,
      'date': date.toIso8601String() // Convert DateTime to string
    };
  }
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'], // Create Product from JSON
      isSentMe: json['isSentMe'],
      date: DateTime.parse(json['date']) // Parse string back to DateTime
    );
  }
}