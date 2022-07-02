import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';

class EtisalatProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ImagePicker _picker = ImagePicker();
  XFile? image;
  String code = '*556*';
  String myOption = '';
  bool flag = true;
  String blockFour = '';
  int counter = 0;
  int current = 0;

  takePhoto(String cameraOrGallery) async {
    if (cameraOrGallery == "camera") {
      final takedIimage = await _picker.pickImage(source: ImageSource.camera);
      image = XFile(takedIimage!.path);
    } else {
      final takedIimage = await _picker.pickImage(source: ImageSource.gallery);
      image = XFile(takedIimage!.path);
    }
  }

  chooseOption(String option) {
    code = option;
  }

  checkLength(String word, int index) async {
    if (counter == 5) {
      flag = false;
      code += blockFour + '#';
      //await launch('tel:${code.toString()}' + '+');
    }
    if (word.length == 3 && double.tryParse(word) != null) {
      if (current == 0) {
        current = index;
        counter++;
        blockFour = blockFour + word;
      } else if (current == index - 1 && counter == 0) {
        current = index;
        counter++;
        blockFour = blockFour + word;
      } else if (counter != 0 && current == index - 1) {
        current = index;
        counter++;
        blockFour = blockFour + word;
      } else {
        counter = 0;
        counter = 0;
      }
    }

    if (word.length == 15 && double.tryParse(word) != null) {
      if (word.startsWith('21') != true) {
        code = code + word + '#';
        flag = false;
      }
    } else if (word.length == 19) {
      String x = '';
      for (var i = 0; i < word.length; i++) {
        if (word[i] != ' ') {
          x += word[i];
        }
      }

      if (x.length == 15) {
        code = code + x + "#";

        flag = false;
        //await launch('tel:${code.toString()}' + '+');
      }
    }
    if (flag == false) {
      //await launch('tel:${code.toString()}' + '+');
    }
  }

  String copyCode() {
    List<String> codes = code.split('*');
    String originalCode = codes[codes.length - 1].replaceAll("#", "");
    return originalCode;
  }

  readTextFromImage() async {
    flag = true;
    counter = 0;
    blockFour = '';
    current = 0;

    FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;
    var currentLabels = await detector.detectFromPath(image!.path);
    for (var i = 0; i < currentLabels.length; i++) {
      if (flag) {
        String line = currentLabels[i].text.replaceAll(RegExp(r' '), '');
        line = line.replaceAll(RegExp(r'-'), '');
        checkLength(line, i);
      } else {
        break;
      }
    }

    notifyListeners();
  }
}
