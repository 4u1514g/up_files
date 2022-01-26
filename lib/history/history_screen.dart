import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loadany/loadany.dart';
import 'package:up_files/api/api_utils.dart';
import 'package:up_files/helper/ruler.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final api = APIUtils(Dio());
  int limit = 30, page = 1;
  // List<HistoryModel> list = [];
  // LoadStatus status = LoadStatus.normal;
  // Future<void> getLoadMore() async {
  //   setState(() {
  //     status = LoadStatus.loading;
  //   });
  //   api.getHistory(50, 1, UserModel.savedAccount!.token!).then((value) {
  //     list.addAll(value.data!);
  //     if (value.data!.isEmpty || value.data!.length < limit) {
  //       status = LoadStatus.completed;
  //     } else {
  //       status = LoadStatus.normal;
  //     }
  //     page += 1;
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   }).onError((error, stackTrace) {
  //     status = LoadStatus.error;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   getLoadMore();
  //   super.initState();
  // }

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
          appBar: Ruler.appBar(),
        ),
      ),
    );
  }
}
