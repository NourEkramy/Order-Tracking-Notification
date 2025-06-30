import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

    final Map<OrderStatus, String> progressSteps = {
      OrderStatus.pending: "✔ Pending ➝ ⭕ Confirmed ➝ ⭕ Shipped ➝ ⭕ Delivered",
      OrderStatus.confirmed:
          "✔ Pending ➝ ✔ Confirmed ➝ ⭕ Shipped ➝ ⭕ Delivered",
      OrderStatus.shipped: "✔ Pending ➝ ✔ Confirmed ➝ ✔ Shipped ➝ ⭕ Delivered",
      OrderStatus.delivered:
          "✔ Pending ➝ ✔ Confirmed ➝ ✔ Shipped ➝ ✔ Delivered",
    };

    String orderId = "#1090";
    String title = "Pharma Seller - Order $orderId";
    String body = progressSteps[newStatus] ?? "Order is now ${newStatus.name}";

    // Send local notification
    await flutterLocalNotificationsPlugin.show(
      newStatus.index,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'hospital_1099047',
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
              children: [
                if (_status.index > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () =>
                        _updateStatus(OrderStatus.values[_status.index - 1]),
                    child: Text(
                      "← ${OrderStatus.values[_status.index - 1].name.toUpperCase()}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                if (_status.index < OrderStatus.values.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xec007aff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () =>
                        _updateStatus(OrderStatus.values[_status.index + 1]),
                    child: Text(
                      "${OrderStatus.values[_status.index + 1].name.toUpperCase()} →",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
