import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';

class WeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ImagePicker _picker = ImagePicker();
  XFile? image;
  String code = '';
  String myOption = '';
  int counter = 0;
  int current = 0;
  String blockFour = '';
  bool flag = true;
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
    myOption = option;
  }

  checkLength(String word, int index) {
    if (counter == 4) {
      flag = false;
      code += blockFour + '#';
      //launch('tel://$code');
    }
    if (word.length == 4 && double.tryParse(word) != null) {
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
    } else if (word.length == 16 && double.tryParse(word) != null) {
      code = myOption + code + word + '#';
      flag = false;
    } else if (word.length == 19) {
      String x = '';
      for (var i = 0; i < word.length; i++) {
        if (word[i] != ' ') {
          x += word[i];
        }
      }

      if (x.length == 16) {
        code = code + x + '#';

        flag = false;
        //launch('tel://$code');
      }
    }
    if (flag == false) {
      // launch('tel://$code');
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
    code = '';
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
