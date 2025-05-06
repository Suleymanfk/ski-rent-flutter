class RentRequest {
  final int userId;
  final int equipmentId;
  final DateTime startTime;
  final DateTime endTime;

  RentRequest({
    required this.userId,
    required this.equipmentId,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'equipmentId': equipmentId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }
}
