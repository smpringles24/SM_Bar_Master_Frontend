import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/data/model/etc_model.dart';

class NewAlbumViewModel with ChangeNotifier {
  AlbumSelectedOption _nowSelected = AlbumSelectedOption.albumTitle;
  AlbumSelectedOption get nowSelected => _nowSelected;

  changeSelectedOption(AlbumSelectedOption option) {
    _nowSelected = option;
    notifyListeners();
  }
}

//############

class NewAlbumData {
  late String date;
  late String albumTitle;
  late String backgroundColor;
  late String cdImage;
  late String cocktailName;
  late String review;

  NewAlbumData({
    this.date = '123',
    this.albumTitle = '132',
    this.backgroundColor = '0xFF475C66',
    this.cdImage = 'lib/assets/user_img01.jpg',
    this.cocktailName = '234235',
    this.review = 'asd',
  });
}

class NewAlbumDataViewModel with ChangeNotifier {
  NewAlbumData _newAlbumData = NewAlbumData();
  NewAlbumData get newAlbumData => _newAlbumData;

  void changeAlbumData() {
    _newAlbumData = NewAlbumData();
    notifyListeners();
  }
}
