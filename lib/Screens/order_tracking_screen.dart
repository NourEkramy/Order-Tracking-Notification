import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:order_tracker/order_tracker.dart';
import '../Widgets/order_card_widget.dart';
import '../Widgets/order_progress_widget.dart';
import '../main.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  OrderStatus _status = OrderStatus.pending;

  void _updateStatus(OrderStatus newStatus) async {
    setState(() {
      _status = newStatus;
    });

    // Send local notification
    await flutterLocalNotificationsPlugin.show(
      newStatus.index,
      'Order Update',
      'Order is now ${newStatus.name}',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );

    // If you're using Firebase to send notification to another device/server, send HTTP request here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Track Order',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Color(0xec007aff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const OrderCardWidget(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: Image.asset(
                'assets/images/take-away-concept-illustration.png',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            OrderProgressWidget(status: _status),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Wrap(
              spacing: 8,
              children: OrderStatus.values.map((s) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xec007aff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onPressed: () => _updateStatus(s),
                  child: Text(
                    s.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
