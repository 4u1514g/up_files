import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:up_files/api/models/user_model.dart';
import 'package:up_files/helper/ruler.dart';
import 'package:http/http.dart' as http;

class UpFilesScreen extends StatefulWidget {
  const UpFilesScreen({Key? key}) : super(key: key);

  @override
  _UpFilesScreenState createState() => _UpFilesScreenState();
}

class _UpFilesScreenState extends State<UpFilesScreen> {
  final List<PlatformFile> _file = [];

  Future getFiles() async {
    await FilePicker.platform.pickFiles(allowMultiple: true).then((value) {
      if (value != null) {
        setState(() {
          _file.addAll(value.files);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
              height: 20,
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
                  height: Ruler.height(context, 60),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: _file.isEmpty
                            ? Container(
                                padding: const EdgeInsets.only(left: 25),
                                width: Ruler.width(context, 80),
                                height: Ruler.height(context, 60) - 80,
                                child: SvgPicture.asset(
                                  'assets/Folder-pana.svg',
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: _file.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.5,
                                                color: Ruler.greyColor))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Ruler.setText(
                                              _file[index].name,
                                              size: Ruler.setSize),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            setState(() {
                                              _file.removeAt(index);
                                            });
                                          },
                                          child: const SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: Icon(Icons.clear),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 80,
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
                  onTap: _file.isNotEmpty
                      ? () async {
                          Ruler.showLoaderDialog(context);
                          var request = http.MultipartRequest(
                              'POST', Uri.parse(Ruler.url + 'insert-file.php'))
                            ..fields['phone'] = UserModel.savedAccount!.phone!
                            ..fields['password'] =
                                UserModel.savedAccount!.password!;
                          for (var file in _file) {
                            request.files.add(await http.MultipartFile.fromPath(
                                'upload[]', file.path!));
                          }
                          await request.send().then((value) {
                            Ruler.cancelLoaderDialog(context);
                            if (value.statusCode == 200) {
                              setState(() {
                                _file.clear();
                              });
                              Ruler.toastSuccess('Upload success');
                            } else {
                              Ruler.toastSuccess('Upload failed');
                            }
                          }).onError((error, stackTrace) {
                            Ruler.toastSuccess('Upload success');
                          });
                        }
                      : null,
                  child: Container(
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                        color: _file.isNotEmpty
                            ? Colors.purpleAccent
                            : Ruler.grey2Color,
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
      ),
    );
  }
}
