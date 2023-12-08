import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sm_bar_master_frontend/data/datasource/remote_datasource.dart';

import 'package:sm_bar_master_frontend/data/model/album_model.dart';
import 'package:sm_bar_master_frontend/data/model/etc_model.dart';

Future<Uint8List?> xfileToUint8List(XFile? image) async {
  if (image == null) return null;
  return await image.readAsBytes();
}

class DataChangeDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final AlbumModel albumModel;
  final AlbumSelectedOption element;
  final int nowSongIndex;

  DataChangeDialog(
      {required this.element,
      required this.albumModel,
      required this.nowSongIndex,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('값 수정하기'),
      content: Builder(builder: (context) {
        switch (element) {
          case AlbumSelectedOption.backgroundColor:
            return ColorEditContainer(albumModel: albumModel);
          case AlbumSelectedOption.albumDate:
            return DateEditContainer(albumModel: albumModel);
          case AlbumSelectedOption.albumImage:
            return ImageEditContainer(albumModel: albumModel);
          default:
            return SimpleEditContainer(
                controller: _controller,
                element: element,
                albumModel: albumModel,
                nowSongIndex: nowSongIndex);
        }
      }),
    );
  }
}

class ColorEditContainer extends StatelessWidget {
  final AlbumModel albumModel;
  final Color currentColor = const Color(0xff123456);

  const ColorEditContainer({required this.albumModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Column(
        children: [
          ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (Color color) {
              String colorString =
                  '0x${color.value.toRadixString(16).padLeft(8, '0')}';
              albumModel.backgroundColor = colorString;
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('수정'),
          ),
        ],
      ),
    );
  }
}

class DateEditContainer extends StatelessWidget {
  final AlbumModel albumModel;
  final DateTime _selectedDate = DateTime.now();

  DateEditContainer({required this.albumModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      color: Colors.black38,
      child: Column(
        children: [
          Container(
            height: 100.0,
            alignment: Alignment.center,
            child: Text(
              "$_selectedDate",
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 250,
            child: ScrollDatePicker(
              selectedDate: _selectedDate,
              locale: const Locale('ko'),
              scrollViewOptions: const DatePickerScrollViewOptions(
                  year: ScrollViewDetailOptions(
                    label: '년',
                    margin: EdgeInsets.only(right: 8),
                  ),
                  month: ScrollViewDetailOptions(
                    label: '월',
                    margin: EdgeInsets.only(right: 8),
                  ),
                  day: ScrollViewDetailOptions(
                    label: '일',
                  )),
              onDateTimeChanged: (DateTime value) {
                albumModel.date = value.toString().substring(0, 10);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('수정'),
          ),
        ],
      ),
    );
  }
}

class ImageEditContainer extends StatefulWidget {
  final AlbumModel albumModel;

  const ImageEditContainer({required this.albumModel, super.key});

  @override
  State<ImageEditContainer> createState() => _ImageEditContainerState();
}

class _ImageEditContainerState extends State<ImageEditContainer> {
  XFile? _selectedImage;
  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
      await uploadImageToS3(_selectedImage);
      print('데이터 업로드!');
      return image;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 500,
            width: 500,
            child: FutureBuilder(
              future: xfileToUint8List(_selectedImage),
              builder:
                  (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  return Image.memory(snapshot.data!);
                } else if (snapshot.error != null) {
                  return const Text('Error loading image');
                } else {
                  return const Text('No image selected.');
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: pickImage,
            child: const Text('Select Image'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('수정'),
          ),
        ],
      ),
    );
  }
}

class SimpleEditContainer extends StatelessWidget {
  const SimpleEditContainer({
    super.key,
    required TextEditingController controller,
    required this.element,
    required this.albumModel,
    required this.nowSongIndex,
  }) : _controller = controller;

  final TextEditingController _controller;
  final AlbumSelectedOption element;
  final AlbumModel albumModel;
  final int nowSongIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 350,
      color: Colors.black38,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: elementToKorean(element),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  switch (element) {
                    case AlbumSelectedOption.albumDate:
                      albumModel.date = _controller.text;
                      break;
                    case AlbumSelectedOption.albumTitle:
                      albumModel.title = _controller.text;
                      break;
                    case AlbumSelectedOption.albumImage:
                      albumModel.imageUrl = _controller.text;
                      break;
                    case AlbumSelectedOption.backgroundColor:
                      albumModel.backgroundColor = _controller.text;
                      break;
                    case AlbumSelectedOption.cdImage:
                      albumModel.songEntities![nowSongIndex].imageUrl =
                          _controller.text;
                      break;
                    case AlbumSelectedOption.cdTitle:
                      albumModel.songEntities![nowSongIndex].title =
                          _controller.text;
                      break;
                    case AlbumSelectedOption.cdReview:
                      albumModel.songEntities![nowSongIndex].content =
                          _controller.text;
                      break;
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('수정'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 영어로 된 열거형을 한글로 바꿔주는 함수
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
