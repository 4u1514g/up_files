import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:up_files/helper/ruler.dart';

class UpFilesScreen extends StatefulWidget {
  const UpFilesScreen({Key? key}) : super(key: key);

  @override
  _UpFilesScreenState createState() => _UpFilesScreenState();
}

class _UpFilesScreenState extends State<UpFilesScreen> {
  bool check = false;
  late File _file;

  Future getFiles() async {

    final file = await FilePicker.platform.pickFiles(allowMultiple: true);
    //if(file)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Ruler.appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 55,
              child: Center(
                child: Ruler.setText('UPLOAD FILES',
                    size: Ruler.setSize + 4,
                    weight: FontWeight.w500,
                    color: Ruler.purpleColor),
              )),
          const SizedBox(
            height: 40,
          ),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            padding: const EdgeInsets.all(10),
            strokeWidth: 2,
            color: Ruler.purple2Color,
            dashPattern: const [10, 5],
            child: Container(
                width: Ruler.width(context, 85),
                height: Ruler.height(context, 50),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: Ruler.width(context, 80),
                        height: Ruler.height(context, 50) - 80,
                        child: SvgPicture.asset(
                          'assets/Folder-pana.svg',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              getFiles();
                            },
                            child: Container(
                              height: 45,
                              width: 160,
                              decoration: BoxDecoration(
                                  color: Ruler.tealColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Ruler.setText('Browse Files',
                                      size: Ruler.setSize,
                                      weight: FontWeight.w500,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  print(_file);
                },
                child: Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                      color: check ? Colors.purpleAccent : Ruler.grey2Color,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Ruler.setText('Upload',
                          size: Ruler.setSize + 2,
                          weight: FontWeight.w500,
                          color: Colors.white)),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
