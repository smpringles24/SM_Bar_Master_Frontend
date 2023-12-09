import 'package:flutter/material.dart';

class MemoryStatusViewer extends StatelessWidget {
  const MemoryStatusViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 500,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}