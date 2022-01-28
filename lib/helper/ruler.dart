import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:up_files/api/models/user_model.dart';

class Ruler {
  static late double setSize;

  void init(BuildContext context) {
    if (MediaQuery.of(context).size.width < 380) {
      setSize = 14;
    } else if (MediaQuery.of(context).size.width < 490) {
      setSize = 15;
    } else if (MediaQuery.of(context).size.width < 600) {
      setSize = 17;
    } else {
      setSize = 18;
    }
  }

  static double width(BuildContext context, double value) {
    return value * MediaQuery.of(context).size.width / 100;
  }

  static double height(BuildContext context, double value) {
    return value * MediaQuery.of(context).size.height / 100;
  }

  static double sizeText(BuildContext context, double value) {
    return ((value * MediaQuery.of(context).size.width / 100) +
            (value * MediaQuery.of(context).size.height / 100)) /
        2;
  }

  static AppBar appBar({Widget? title,Color? color,bool? leading}) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: leading??false,
      toolbarHeight: title == null ? 0 : 56,
      title: title,
      centerTitle: true,
      backgroundColor: color??primaryColor ,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: color??primaryColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark),
    );
  }

  static Widget setText(String value,
      {FontWeight? weight,
      @required double? size,
      Color? color,
      TextDecoration? through,
      int? maxLine,
      TextOverflow? overFlow,
      TextAlign? textAlign}) {
    return Text(
      value,
      maxLines: maxLine,
      overflow: overFlow,
      textAlign: textAlign,
      style: TextStyle(
          fontWeight: weight,
          fontSize: size,
          color: color,
          decoration: through),
    );
  }

  static double tryParseStringToDouble(String value) {
    return double.tryParse(value)!;
  }

  static int tryParseStringToInt(String value) {
    return int.tryParse(value)!;
  }

  static String tryParseDoubleToString(double value) {
    return value.toString();
  }

  static String tryParseDoubleToMoney(double value) {
    if (value % 1 == 0) {
      return NumberFormat("#,###", "vi_VI").format(value);
    } else {
      return NumberFormat("#,##0.00", "vi_VI").format(value);
    }
  }

  static String tryParseIntToMoney(int value) {
    final oCcy = NumberFormat("#.###", "vi_VI");
    return oCcy.format(value);
  }

  static String formatPhone(String value) {
    return '(${value.substring(0, 3)}) ${value.substring(3, 6)}-${value.substring(6, 10)}';
  }

  static void showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // EasyLoading.show(
        //     maskType: EasyLoadingMaskType.clear, status: "Loading...");
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Container(
                width: Ruler.width(context, 40),
                height: Ruler.width(context, 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: EdgeInsets.all(Ruler.width(context, 2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Ruler.width(context, 10),
                      height: Ruler.width(context, 10),
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineSpinFadeLoader,
                        colors: [
                          Colors.blue,
                          Colors.green,
                          Colors.yellow,
                          Colors.orange,
                          Colors.red,
                          Colors.redAccent,
                          Colors.purple,
                          Ruler.xanhDam
                        ],
                        strokeWidth: 1,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(
                                top: Ruler.height(context, 0.75)),
                            child: const Text("Loading...",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16))))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static toastSuccess(String content) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static toastError(String content) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  static cancelLoaderDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static Future<String> get _localPath async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/UserAccount.txt');
  }

  static Future<File> writeAccount(UserModel valueIn) async {
    final file = await _localFile;
    String account = json.encode(valueIn).toString();

    return file.writeAsString(account);
  }

  static Future<void> deleteFile() async {
    try {
      final file = await _localFile;
      await file.delete();
    // ignore: empty_catches
    } catch (e) {}
  }

  static Future<UserModel> readAccount() async {
    final file = await _localFile;
    String contents = await file.readAsString();
    UserModel ert = UserModel.fromJson(json.decode(contents));
    UserModel.savedAccount = ert;
    return UserModel.savedAccount!;
  }


  static const String url = 'http://trangapp.okechua.com/api/';

  static Color primaryColor = const Color(0xffeb1a6c);
  static Color orangeColor = const Color(0xFFF79A21);
  static Color orange1Color = const Color(0xFFEBAA57);
  static Color redColor = const Color(0xFFFF0000);
  static Color pink = const Color(0xffeb1a6c);
  static Color pink2 = const Color(0xffFFCFDC);
  static Color xanhDam = const Color(0xff084977);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color blackColor = const Color(0xFF18181A);
  static Color grey2Color = const Color(0xFFC4C4C4);
  static Color grey3Color = const Color(0xFFd9d9d9);
  static Color greyColor = const Color(0xFF999999);
  static Color blueColor = const Color(0xFF28A8E0);
  static Color greenColor = const Color(0xFF00C22D);
  static Color overtimeColorSchedule = const Color(0x27FF0000);
  static Color nowtimeColorSchedule = const Color(0x26FF9800);
  static Color disableColor = const Color(0x59000000);
  static Color orderMenuBoderColor = const Color(0xFFEB1A6C);
  static Color orderMenuInsideColor = const Color(0xFFFFCFDC);
  static Color backGroundColor = const Color(0xffc9c9c9);
  static Color redCardColor = const Color(0xffEB5757);
  static Color purpleColor = const Color(0xff9a9bcb);
  static Color purple2Color = const Color(0xffACABD3);
  static Color tealColor = const Color(0xff8ab9e3);
}

class MoneyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newString = newValue.text.replaceAll('.', '');
    String text= NumberFormat("#,###", "vi_VI").format(int.parse(newString));
    return TextEditingValue(
      text: text,selection: TextSelection.fromPosition(TextPosition(offset: text.length))
    );
  }
}
