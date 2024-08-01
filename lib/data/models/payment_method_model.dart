class PaymentMethod {
  final String id;
  final String name;
  final String type;
  final String details;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    required this.details,
  });

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      details: map['details'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'details': details,
    };
  }
}
