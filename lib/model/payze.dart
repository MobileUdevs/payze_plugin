class Payze {
  String number;
  String cardHolder;
  String expirationDate;
  String securityNumber;
  String transactionId;

  Payze({
    required this.number,
    required this.cardHolder,
    required this.expirationDate,
    required this.securityNumber,
    required this.transactionId,
  });

  Map<String, String> toJson() {
    return {
      'number': number,
      'cardHolder': cardHolder,
      'expirationDate': expirationDate,
      'securityNumber': securityNumber,
      'transactionId': transactionId,
    };
  }
}
