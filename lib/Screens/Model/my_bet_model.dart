class MyBetModel {
  MyBetModel({
    required this.error,
    required this.message,
    required this.data,
  });

  final bool? error;
  final String? message;
  final List<Datum> data;

  factory MyBetModel.fromJson(Map<String, dynamic> json){
    return MyBetModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.amount,
    required this.number,
    required this.type,
    required this.transactionType,
    required this.created,
  });

  final String? id;
  final String? userId;
  final String? vendorId;
  final String? amount;
  final dynamic number;
  final String? type;
  final String? transactionType;
  final DateTime? created;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      userId: json["user_id"],
      vendorId: json["vendor_id"],
      amount: json["amount"],
      number: json["number"],
      type: json["type"],
      transactionType: json["transaction_type"],
      created: DateTime.tryParse(json["created"] ?? ""),
    );
  }

}
