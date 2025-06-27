import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
import '../Widgets/order_card_widget.dart';
import '../Widgets/order_progress_widget.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Color(0xedff4f5a),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Track Order', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10)
          )
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const OrderCardWidget(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.023),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/3333449.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            OrderProgressWidget(status: Status.order),
          ],
        ),
      ),
    );
  }
}
