import 'package:flutter/material.dart';

enum selectedOption {
  albumTitle,
  date,
  backgroundColor,
  cdImage,
  cocktailName,
  review
}

class NewAlbumViewModel with ChangeNotifier {
  selectedOption _nowSelected = selectedOption.albumTitle;
  selectedOption get nowSelected => _nowSelected;

  changeSelectedOption(selectedOption option) {
    _nowSelected = option;
    notifyListeners();
  }
}
