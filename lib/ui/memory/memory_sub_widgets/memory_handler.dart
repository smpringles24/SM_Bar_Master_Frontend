import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/data/datasource/remote_datasource.dart';
import 'package:sm_bar_master_frontend/ui/memory/memory_view_model.dart';

class MemoryHandler extends StatelessWidget {
  const MemoryHandler({
    super.key,
    required this.memoryViewModel,
    required this.snapshot,
  });

  final MemoryViewModel memoryViewModel;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () async {
            if (snapshot.data!.isNotEmpty) {
              bool isDeleted = await deleteAlbum(snapshot.data![0].albumId!);
              if (isDeleted) {
                memoryViewModel.fetchdata();
              } else {
                //삭제 실패
              }
            } else {
              //TODO: sncak bar로 알림
            }
          },
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.white,
            size: 30,
          ),
        ),
      ],
    );
  }
}

