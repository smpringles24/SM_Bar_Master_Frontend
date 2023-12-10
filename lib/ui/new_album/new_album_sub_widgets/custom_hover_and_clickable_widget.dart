import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/utils/types.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_sub_widgets/data_change_dialog.dart';
import 'package:sm_bar_master_frontend/ui/new_album/new_album_view_model.dart';

class CustomHoverAndClickableWidget extends StatelessWidget {
  final NewAlbumViewModel newAlbumViewModel;
  final AlbumSelectedOption type;
  final Widget child;

  const CustomHoverAndClickableWidget({
    super.key,
    required this.newAlbumViewModel,
    required this.type,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => newAlbumViewModel.changeSelectedOption(type),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DataChangeDialog(
                newAlbumViewModel: newAlbumViewModel,
                element: type,
              );
            },
          );
        },
        child: child,
      ),
    );
  }
}
