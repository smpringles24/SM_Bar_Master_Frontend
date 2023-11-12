import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_bar_master_frontend/ui/memory/memory_view.dart';
import 'package:sm_bar_master_frontend/ui/memory/memory_view_model.dart';

class MemoryPage extends StatelessWidget {
  const MemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemoryViewModel(),
      child: const MemoryView(),
    );
  }
}
