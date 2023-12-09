import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<Uint8List?> xfileToUint8List(XFile? image) async {
  if (image == null) {
    return null;
  } else {
    return await image.readAsBytes();
  }
}
