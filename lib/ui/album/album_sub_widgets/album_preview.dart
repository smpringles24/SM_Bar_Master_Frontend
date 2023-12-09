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
    return SizedBox(
      child: snapshot.data!.imageUrl! ==
              'lib/assets/image_placeholder_no_image.png'
          ? Image.asset(
              snapshot.data!.imageUrl!,
              fit: BoxFit.cover,
            )
          : Image.network(
              snapshot.data!.imageUrl!,
              fit: BoxFit.fill,
            ),
    );
  }
}
