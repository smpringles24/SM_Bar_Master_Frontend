import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/utils/types.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_sub_widgets/custom_hover_and_clickable_widget.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';
import 'package:sm_bar_master_frontend/utils/image_data_convert.dart';

class AlbumEditPreview extends StatelessWidget {
  final NewAlbumViewModel newAlbumViewModel;

  const AlbumEditPreview({super.key, required this.newAlbumViewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomHoverAndClickableWidget(
        newAlbumViewModel: newAlbumViewModel,
        type: AlbumSelectedOption.albumImage,
        child: FutureBuilder<Uint8List?>(
          future:
              xfileToUint8List(newAlbumViewModel.newAlbumTitlePreviewImage),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: 600,
                height: 600,
                child: Image.memory(snapshot.data!),
              );
            } else {
              return Container(
                width: 600,
                height: 600,
                color: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }
}
