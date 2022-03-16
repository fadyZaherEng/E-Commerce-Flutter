import 'package:flutter_technical_task/utils/ar.dart';
import 'package:flutter_technical_task/utils/en.dart';
import 'package:get/get.dart';

class myTranslation extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en':en,
    'ar':ar
  };

}