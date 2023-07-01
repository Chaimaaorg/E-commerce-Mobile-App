class Order {
  String uid;
  String status;
  double amount;
  DateTime creationDate;
  Map<String, dynamic> prodQte;  // Use Map<String, dynamic> for prodQte

  Order({
    required this.uid,
    required this.status,
    required this.amount,
    required this.creationDate,
    required this.prodQte,  // Use Map<String, dynamic> for prodQte
  });

  // Convert the Order object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'status': status,
      'amount': amount,
      'creationDate': creationDate.toIso8601String(),
      'prodQte': prodQte,
    };
  }

  // Create an Order object from JSON data
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      uid: json['uid'],
      status: json['status'],
      amount: json['amount'],
      creationDate: DateTime.parse(json['creationDate']),
      prodQte: Map<String, dynamic>.from(json['prodQte']),
    );
  }
}
