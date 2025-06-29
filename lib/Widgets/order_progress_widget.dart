import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

enum OrderStatus { pending, confirmed, shipped, delivered }

class OrderProgressWidget extends StatefulWidget {
  final OrderStatus status;

  const OrderProgressWidget({super.key, required this.status});

  @override
  State<OrderProgressWidget> createState() => _OrderProgressWidgetState();
}

class _OrderProgressWidgetState extends State<OrderProgressWidget> {
  Color _getColor(OrderStatus current) {
    if (widget.status.index >= current.index) {
      return Color(0xec007aff);
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // This ensures no inherited background
      child: Column(
        children: [
          _buildTile("Pending", OrderStatus.pending),
          _buildTile("Confirmed", OrderStatus.confirmed),
          _buildTile("Shipped", OrderStatus.shipped),
          _buildTile("Delivered", OrderStatus.delivered, isLast: true),
        ],
      ),
    );
  }

  TimelineTile _buildTile(
    String label,
    OrderStatus step, {
    bool isLast = false,
  }) {
    final currentIndex = widget.status.index;
    final stepIndex = step.index;

    final beforeLineColor = stepIndex == 0
        ? Colors
              .transparent // no before line for first
        : (stepIndex <= currentIndex ? const Color(0xec007aff) : Colors.grey);

    final afterLineColor = stepIndex < currentIndex
        ? const Color(0xec007aff)
        : Colors.grey;

    return TimelineTile(
      isFirst: step == OrderStatus.pending,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(width: 20, color: _getColor(step)),
      beforeLineStyle: LineStyle(color: beforeLineColor, thickness: 3),
      afterLineStyle: LineStyle(color: afterLineColor, thickness: 3),
      endChild: Container(
        height: 70,
        color: Colors.white,
        child: Center(child: Text(label, style: const TextStyle(fontSize: 16))),
      ),
    );
  }
}
