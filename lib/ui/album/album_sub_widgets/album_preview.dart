import 'package:flutter/material.dart';

import 'package:sm_bar_master_frontend/data/model/album_model.dart';
class AlbumPreview extends StatelessWidget {
  const AlbumPreview({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot<AlbumModel> snapshot;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      snapshot.data!.imageUrl!,
      height: 600,
      width: 600,
    );
  }
}