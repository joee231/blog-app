import 'dart:io';

import 'package:blogapp/core/utils/pick_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File?> pickImage() async {


  try{

      final xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (xfile != null) {
        return File(xfile.path);
      }
      return null;
  }catch(e)
  {
    return null; // Placeholder return
  }

}


