import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadany/loadany.dart';
import 'package:up_files/api/api_utils.dart';
import 'package:up_files/api/models/file_model.dart';
import 'package:up_files/api/models/user_model.dart';
import 'package:up_files/helper/ruler.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final api = APIUtils(Dio());
  int limit = 9999, page = 1;
  List<FileModel> list = [];
  LoadStatus status = LoadStatus.normal;

  Future<void> getLoadMore() async {
    setState(() {
      status = LoadStatus.loading;
    });
    api
        .getFiles(
            UserModel.savedAccount!.phone!, UserModel.savedAccount!.password!)
        .then((value) {
      list.addAll(value);
      if (value.isEmpty || value.length < limit) {
        status = LoadStatus.completed;
      } else {
        status = LoadStatus.normal;
      }
      page += 1;
      if (!mounted) {
        return;
      }
      setState(() {});
    }).onError((error, stackTrace) {
      status = LoadStatus.error;
    });
  }

  late Future<List<FileModel>> _future;

  @override
  void initState() {
    getLoadMore();
    _future = api.getFiles(
        UserModel.savedAccount!.phone!, UserModel.savedAccount!.password!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          // setState(() {
          //   list.clear();
          //   page = 1;
          //   getLoadMore();
          // });
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: Ruler.appBar(),
          body: Column(
            children: [
              SizedBox(
                  height: 55,
                  child: Center(
                    child: Ruler.setText('HISTORY',
                        size: Ruler.setSize + 4,
                        weight: FontWeight.w500,
                        color: Ruler.purpleColor),
                  )),
              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder<List<FileModel>>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.hasError) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      } else {
                        return Wrap(
                          children: List.generate(
                              snapshot.data!.length,
                              (index) => Container(
                                    margin: const EdgeInsets.all(10),
                                    height: 130,
                                    width: 150,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.yellow[700],
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                            child: Ruler.setText(
                                                snapshot.data![index].name!
                                                        .contains('.')
                                                    ? snapshot
                                                        .data![index].name!
                                                        .substring(snapshot
                                                            .data![index].name!
                                                            .lastIndexOf('.'))
                                                    : 'none',
                                                size: Ruler.setSize + 6,
                                                weight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Ruler.setText(
                                            snapshot.data![index].name!,
                                            size: Ruler.setSize - 1,
                                            color: Colors.black,
                                            weight: FontWeight.w500,
                                            maxLine: 1,
                                            overFlow: TextOverflow.ellipsis)
                                      ],
                                    ),
                                  )),
                        );
                      }
                    },
                  ),
                ),
              )
              // Expanded(
              //   child: LoadAny(
              //     status: status,
              //     onLoadMore: getLoadMore,
              //     loadMoreBuilder: (context, status) =>
              //         const CupertinoActivityIndicator(),
              //     errorMsg: 'Erorr',
              //     loadingMsg: 'Loading...',
              //     finishMsg: '',
              //     child: CustomScrollView(
              //       slivers: [
              //         SliverToBoxAdapter(
              //           child: Wrap(
              //             children: List.generate(
              //                 list.length,
              //                 (index) => Container(
              //                       decoration: BoxDecoration(
              //                           color: Ruler.orangeColor,
              //                           borderRadius:
              //                               BorderRadius.circular(15)),
              //                       height: 80,
              //                       width: 120,
              //                       child: Center(
              //                         child: Ruler.setText(
              //                             list[index].name!.substring(
              //                                 list[index]
              //                                     .name!
              //                                     .lastIndexOf('.')),
              //                             size: Ruler.setSize),
              //                       ),
              //                     )),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
