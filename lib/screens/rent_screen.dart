import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/equipment_model.dart';
import '../models/rent_request.dart';
import '../services/rent_service.dart';

class RentScreen extends StatefulWidget {
  final Equipment equipment;

  RentScreen({required this.equipment});

  @override
  _RentScreenState createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  DateTime? startTime;
  DateTime? endTime;
  String message = "";

  void _submitRental() async {
    if (startTime == null || endTime == null) {
      setState(() => message = "Please select both start and end time.");
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;

    final request = RentRequest(
      userId: userId,
      equipmentId: widget.equipment.id,
      startTime: startTime!,
      endTime: endTime!,
    );

    final result = await RentService().rentEquipment(request);

    setState(() {
      message = result;
    });
  }

  Future<void> _pickDateTime(bool isStart) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    DateTime fullDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      if (isStart) {
        startTime = fullDateTime;
      } else {
        endTime = fullDateTime;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rent ${widget.equipment.name}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.calendar_month, size: 80, color: Theme.of(context).primaryColor),
            SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Start Time", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text(startTime != null ? startTime.toString() : "Not selected",
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_calendar),
                    onPressed: () => _pickDateTime(true),
                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("End Time", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text(endTime != null ? endTime.toString() : "Not selected",
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_calendar),
                    onPressed: () => _pickDateTime(false),
                  ),
                ],
              ),
            ),

            ElevatedButton.icon(
              onPressed: _submitRental,
              icon: Icon(Icons.shopping_cart),
              label: Text("Rent Now"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            SizedBox(height: 20),
            if (message.isNotEmpty)
              Text(
                message,
                style: TextStyle(
                  color: message.toLowerCase().contains("success") ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
