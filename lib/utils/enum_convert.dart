import 'package:sm_bar_master_frontend/utils/types.dart';

/// 영어로 된 열거형을 한글로 매핑하는 함수
String elementToKorean(AlbumSelectedOption element) {
  if (element == AlbumSelectedOption.albumDate) {
    return '날짜';
  } else if (element == AlbumSelectedOption.albumTitle) {
    return '앨범 제목';
  } else if (element == AlbumSelectedOption.albumImage) {
    return '앨범 이미지';
  } else if (element == AlbumSelectedOption.backgroundColor) {
    return '배경색';
  } else if (element == AlbumSelectedOption.cdImage) {
    return 'CD 이미지';
  } else if (element == AlbumSelectedOption.cdTitle) {
    return '칵테일 이름';
  } else if (element == AlbumSelectedOption.cdReview) {
    return '리뷰';
  } else {
    return '오류';
  }
}