import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sm_bar_master_frontend/ui/memory/memory_sub_widgets/memory_handler.dart';
import 'package:sm_bar_master_frontend/ui/memory/memory_sub_widgets/memory_status_viewer.dart';
import 'package:sm_bar_master_frontend/ui/memory/memory_sub_widgets/memory_viewer.dart';
import 'package:sm_bar_master_frontend/ui/memory/memory_view_model.dart';

class MemoryView extends StatelessWidget {
  const MemoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final memoryViewModel = Provider.of<MemoryViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.black87,
      body: FutureBuilder(
        future: memoryViewModel.memoryPreviewImages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('에러 발생: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return _MainPage(
                memoryViewModel: memoryViewModel, snapshot: snapshot);
          } else {
            return const Text('데이터가 없습니다.');
          }
        },
      ),
    );
  }
}

class _MainPage extends StatelessWidget {
  const _MainPage({
    required this.memoryViewModel,
    required this.snapshot,
  });

  final MemoryViewModel memoryViewModel;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
          child: MemoryHandler(
              memoryViewModel: memoryViewModel, snapshot: snapshot),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
            child: MemoryViewer(
                memoryViewModel: memoryViewModel, snapshot: snapshot),
          ),
        ),
        const MemoryStatusViewer(),
      ],
    );
  }
}
