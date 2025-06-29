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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xec007aff),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text('Track Order', style: TextStyle(color: Colors.white, fontSize: 30)),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const OrderCardWidget(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.023),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12,),
              child: Image.asset(
                'assets/images/take-away-concept-illustration.png',
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
