import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_bar_master_frontend/ui/album/album_view.dart';
import 'package:sm_bar_master_frontend/ui/album/album_view_model.dart';

class AlbumPage extends StatelessWidget {
  final int albumId;

  const AlbumPage({required this.albumId, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AlbumViewModel(),
      child: AlbumView(
        albumId: albumId,
      ),
    );
  }
}
