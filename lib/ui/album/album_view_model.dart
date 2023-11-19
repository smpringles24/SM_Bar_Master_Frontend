import 'package:flutter/material.dart';

class AlbumViewModel with ChangeNotifier {
  int _nowSongIndex = 0;
  int get nowSongIndex => _nowSongIndex;

  setNowSongIndex(int index) {
    _nowSongIndex = index;
    notifyListeners();
  }
}
