import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';

class OrderProgressWidget extends StatefulWidget {
  final Status status;

  const OrderProgressWidget({super.key, required this.status});

  @override
  _OrderProgressWidgetState createState() => _OrderProgressWidgetState();
}

class _OrderProgressWidgetState extends State<OrderProgressWidget> {
  late Status status;

  @override
  void initState() {
    super.initState();
    status = widget.status; // Initialize from passed status
  }

  void updateStatus(Status newStatus) {
    setState(() {
      status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<TextDto> orderedList = [TextDto("Order pending", "")];

    final List<TextDto> shippedList = [TextDto("Order confirmed", "")];

    final List<TextDto> outForDeliveryList = [TextDto("Order shipped", "")];

    final List<TextDto> deliveredList = [TextDto("Order delivered", "")];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: OrderTracker(
            key: ValueKey(status),
            status: status,
            activeColor: Color(0xedff4f5a),
            inActiveColor: Colors.grey[400],
            orderTitleAndDateList: orderedList,
            shippedTitleAndDateList: shippedList,
            outOfDeliveryTitleAndDateList: outForDeliveryList,
            deliveredTitleAndDateList: deliveredList,
          ),
        ),
        // Example buttons to test status change
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xedff4f5a),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => updateStatus(Status.order),
                    child: const Text("Set Ordered"),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xedff4f5a),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => updateStatus(Status.shipped),
                    child: const Text("Set Shipped"),
                  ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xedff4f5a),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => updateStatus(Status.outOfDelivery),
                    child: const Text("Set Out of delivery"),
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xedff4f5a),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => updateStatus(Status.delivered),
                    child: const Text("Set Delivered"),
                  ),

                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            ],
          ),
        ),
      ],
    );
  }
}
