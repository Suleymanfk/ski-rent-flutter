class Rental {
  final int rentalId;
  final String imageUrl;
  final DateTime startTime;
  final DateTime endTime;
  final double totalPrice;
  final String equipmentName;

  Rental({
    required this.rentalId,
    required this.imageUrl,
    required this.startTime,
    required this.endTime,
    required this.totalPrice,
    required this.equipmentName,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      rentalId: json['rentalId'] ?? 0,
      imageUrl: json['equipment']?['imageUrl'] ?? '',
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'])
          : DateTime.now(),
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'])
          : DateTime.now().add(Duration(hours: 1)),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      equipmentName: json['equipment']?['name'] ?? 'Unknown Equipment',
    );
  }
}
