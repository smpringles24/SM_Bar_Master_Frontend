import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';

class NewAlbumPage extends StatelessWidget {
  const NewAlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewAlbumViewModel()),
      ],
      child: const NewAlbumView(),
    );
  }
}
