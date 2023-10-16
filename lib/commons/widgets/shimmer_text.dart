import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerPlaceholder(BuildContext context, String text) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey[700],
      ),
    ),
  );
}
