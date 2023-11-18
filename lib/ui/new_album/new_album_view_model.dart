import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/data/model/album_model.dart';
import 'package:sm_bar_master_frontend/data/model/etc_model.dart';
import 'package:sm_bar_master_frontend/data/model/song_entity.dart';

class NewAlbumViewModel with ChangeNotifier {
  AlbumSelectedOption _nowSelected = AlbumSelectedOption.albumTitle;
  AlbumSelectedOption get nowSelected => _nowSelected;

  changeSelectedOption(AlbumSelectedOption option) {
    _nowSelected = option;
    notifyListeners();
  }

  //############

  int _nowSongIndex = 0;
  int get nowSongIndex => _nowSongIndex;

  setNowSongIndex(int index) {
    _nowSongIndex = index;
    notifyListeners();
  }

  //############

  AlbumModel _albumModel = AlbumModel();
  AlbumModel get albumModel => _albumModel;

  void changeAlbumData() {
    _albumModel = AlbumModel();
    notifyListeners();
  }

  void addSongEntity(SongEntity songEntity) {
    _albumModel.songEntities!.add(songEntity);
    notifyListeners();
  }
}
