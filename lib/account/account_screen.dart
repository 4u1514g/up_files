import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:up_files/api/api_utils.dart';
import 'package:up_files/api/models/user_model.dart';
import 'package:up_files/helper/ruler.dart';

import 'login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController old = TextEditingController();
  TextEditingController newp = TextEditingController();
  TextEditingController cnewp = TextEditingController();
  FocusNode newNode = FocusNode();
  FocusNode cnewNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Ruler.appBar(),
      body: Stack(
        children: [
          SizedBox(
            height: Ruler.height(context, 90),
            child: SvgPicture.asset('assets/Following-cuate.svg'),
          ),
          Positioned.fill(
              top: 15,
              child: Column(
                children: [
                  SizedBox(
                      child: SvgPicture.asset(
                    'assets/user_icon-icons.com_66546.svg',
                    height: Ruler.height(context, 16),
                    width: Ruler.height(context, 16),
                  )),
                  SizedBox(
                    height: Ruler.height(context, 40),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      String zxc = '';
                      old.clear();
                      newp.clear();
                      cnewp.clear();
                      bool sold = true, snew = true, scnew = true;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                              builder: (context, setState) => Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: Ruler.width(context, 5)),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 350,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        const  SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Ruler.grey2Color,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  obscureText: sold,
                                                  controller: old,
                                                  onChanged: (value) {
                                                    setState(() {});
                                                    old.addListener(() {});
                                                  },
                                                  onFieldSubmitted: (value) {
                                                    FocusScope.of(context)
                                                        .requestFocus(newNode);
                                                  },
                                                  textCapitalization:
                                                      TextCapitalization.none,
                                                  style: TextStyle(
                                                      fontSize: Ruler.setSize,
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                    isCollapsed: true,
                                                    isDense: true,
                                                    contentPadding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    hintText: 'Password',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize:
                                                            Ruler.setSize + 1),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      sold = !sold;
                                                    });
                                                  },
                                                  child: SvgPicture.asset(sold
                                                      ? 'assets/hide.svg'
                                                      : 'assets/show.svg')),
                                              const SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                        zxc.isEmpty
                                            ? const SizedBox(
                                                height: 15,
                                              )
                                            : Container(
                                                margin:const  EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Ruler.setText(zxc,
                                                    size: Ruler.setSize,
                                                    color: Ruler.redColor)),
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Ruler.grey2Color,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  obscureText: snew,
                                                  focusNode: newNode,
                                                  controller: newp,
                                                  onChanged: (value) {
                                                    setState(() {});
                                                    newp.addListener(() {});
                                                  },
                                                  onFieldSubmitted: (value) {
                                                    FocusScope.of(context)
                                                        .requestFocus(cnewNode);
                                                  },
                                                  textCapitalization:
                                                      TextCapitalization.none,
                                                  style: TextStyle(
                                                      fontSize: Ruler.setSize,
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                    isCollapsed: true,
                                                    isDense: true,
                                                    contentPadding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    hintText: 'New password',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize:
                                                            Ruler.setSize + 1),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      snew = !snew;
                                                    });
                                                  },
                                                  child: SvgPicture.asset(snew
                                                      ? 'assets/hide.svg'
                                                      : 'assets/show.svg')),
                                              const SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Ruler.grey2Color,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  obscureText: scnew,
                                                  controller: cnewp,
                                                  focusNode: cnewNode,
                                                  onChanged: (value) {
                                                    setState(() {});
                                                    cnewp.addListener(() {});
                                                  },
                                                  textCapitalization:
                                                      TextCapitalization.none,
                                                  style: TextStyle(
                                                      fontSize: Ruler.setSize,
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                    isCollapsed: true,
                                                    isDense: true,
                                                    contentPadding:
                                                    const  EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    hintText:
                                                        'Confirm password',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize:
                                                            Ruler.setSize + 1),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      snew = !snew;
                                                    });
                                                  },
                                                  child: SvgPicture.asset(snew
                                                      ? 'assets/hide.svg'
                                                      : 'assets/show.svg')),
                                              const  SizedBox(
                                                width: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                        (newp.text.isNotEmpty &&
                                                cnewp.text.isNotEmpty &&
                                                newp.text != cnewp.text)
                                            ? Container(
                                                margin: const EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Ruler.setText(
                                                    'Incorrect password',
                                                    size: Ruler.setSize,
                                                    color: Ruler.redColor))
                                            : const SizedBox(
                                                height: 15,
                                              ),
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: (newp.text.isNotEmpty &&
                                                        newp.text == cnewp.text)
                                                    ? () async {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        Ruler.showLoaderDialog(
                                                            context);
                                                        await APIUtils(Dio())
                                                            .upadteInfor(
                                                                UserModel
                                                                    .savedAccount!
                                                                    .phone!,
                                                                old.text,
                                                                newp.text,
                                                                UserModel
                                                                    .savedAccount!
                                                                    .name!)
                                                            .then((value) {
                                                          Ruler
                                                              .cancelLoaderDialog(
                                                                  context);
                                                          Ruler.toastSuccess(
                                                              'Success');
                                                          Navigator.pop(
                                                              this.context);
                                                        }).onError((error,
                                                                stackTrace) {
                                                          if (error
                                                              is DioError) {
                                                            if (error.response!
                                                                    .statusCode ==
                                                                400) {
                                                              setState(() {
                                                                zxc =
                                                                    'Incorrect password';
                                                              });
                                                            }
                                                          }
                                                          Ruler
                                                              .cancelLoaderDialog(
                                                                  context);
                                                        });
                                                      }
                                                    : null,
                                                child: Container(
                                                  width:
                                                      Ruler.width(context, 65),
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                      color: (newp.text
                                                                  .isNotEmpty &&
                                                              newp.text ==
                                                                  cnewp.text)
                                                          ? Ruler.blueColor
                                                          : Ruler.greyColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Center(
                                                      child: Ruler.setText(
                                                          'Change password',
                                                          size:
                                                              Ruler.setSize + 2,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )));
                        },
                      );
                    },
                    child: Container(
                      height: 48,
                      width: Ruler.width(context, 90),
                      decoration: BoxDecoration(
                          color: Ruler.orangeColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Ruler.setText('Change password',
                            size: Ruler.setSize + 2,
                            color: Colors.white,
                            weight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      await Ruler.deleteFile().then((value) {
                        UserModel.savedAccount = null;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InitScreen()),
                            (route) => false);
                      });
                    },
                    child: Container(
                      height: 48,
                      width: Ruler.width(context, 90),
                      decoration: BoxDecoration(
                          color: Ruler.blueColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Ruler.setText('Sign out',
                            size: Ruler.setSize + 2,
                            color: Colors.white,
                            weight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
