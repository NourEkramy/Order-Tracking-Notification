import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        child: Column(
          children: const [
            _DetailRow(label: 'Estimated Time', value: '30 minutes'),
            _DetailRow(label: 'Order Number', value: '#11223344'),
            _DetailRow(label: 'Order Price', value: '300\$'),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.5.sp),
          ),
          Text(value),
        ],
      ),
    );
  }
}
