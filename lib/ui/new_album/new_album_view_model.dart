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

  SongEntity getSongEntity(int index) {
    if (_albumModel.songEntities!.length <= index) {
      print('songEntity index out of range');
    }
    return _albumModel.songEntities![index];
  }
}
