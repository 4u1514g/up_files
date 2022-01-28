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
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                        height: 160,
                        width: Ruler.width(context, 70),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                                top: 65,
                                bottom: 0,
                                width: Ruler.width(context, 70),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Ruler.purpleColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                      onTap: () async {
                                        TextEditingController zxc =
                                            TextEditingController();
                                        await showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                                  insetPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal:
                                                              Ruler.width(
                                                                  context, 5)),
                                                  child: Container(
                                                    height: 300,
                                                    width: Ruler.width(
                                                        context, 90),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Column(children: [
                                                      Ruler.setText(
                                                          "Enter new name",
                                                          size:
                                                              Ruler.setSize + 4,
                                                          color: Colors.black,
                                                          weight:
                                                              FontWeight.w500),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextFormField(
                                                        controller: zxc,
                                                        decoration: const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            15)),
                                                      ),
                                                      Expanded(
                                                          child: Container(
                                                        height: 45,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            GestureDetector(
                                                              behavior:
                                                                  HitTestBehavior
                                                                      .opaque,
                                                              onTap: () async {
                                                                Ruler.showLoaderDialog(
                                                                    context);
                                                                await APIUtils(
                                                                        Dio())
                                                                    .upadteInfor(
                                                                        UserModel
                                                                            .savedAccount!
                                                                            .phone!,
                                                                        UserModel
                                                                            .savedAccount!
                                                                            .password!,
                                                                        UserModel
                                                                            .savedAccount!
                                                                            .password!,
                                                                        zxc
                                                                            .text)
                                                                    .then(
                                                                        (value) async {
                                                                  Ruler.cancelLoaderDialog(
                                                                      context);
                                                                  await Ruler
                                                                      .writeAccount(
                                                                          value);
                                                                  await Ruler
                                                                      .readAccount();
                                                                  Ruler.toastSuccess(
                                                                      'Success');
                                                                  Navigator.pop(
                                                                      this.context,
                                                                      'ok');
                                                                }).onError((error,
                                                                        stackTrace) {
                                                                  Ruler.toastError(
                                                                      'Failed');
                                                                  Ruler.cancelLoaderDialog(
                                                                      context);
                                                                }).then((value) {
                                                                  if (value ==
                                                                      'ok') {
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Ruler
                                                                        .orangeColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                width:
                                                                    Ruler.width(
                                                                        context,
                                                                        38),
                                                                height: 45,
                                                                child: Center(
                                                                  child: Ruler.setText(
                                                                      'SAVE',
                                                                      size: Ruler
                                                                          .setSize,
                                                                      color: Colors
                                                                          .white,
                                                                      weight: FontWeight
                                                                          .w500),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              behavior:
                                                                  HitTestBehavior
                                                                      .opaque,
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Ruler
                                                                        .blueColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                width:
                                                                    Ruler.width(
                                                                        context,
                                                                        38),
                                                                height: 45,
                                                                child: Center(
                                                                  child: Ruler.setText(
                                                                      'CANCEL',
                                                                      size: Ruler
                                                                          .setSize,
                                                                      color: Colors
                                                                          .white,
                                                                      weight: FontWeight
                                                                          .w500),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ))
                                                    ]),
                                                  ),
                                                ));
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 45,
                                          width: 45,
                                          child: SvgPicture.asset(
                                            'assets/edit-svgrepo-com.svg',
                                            height: 25,
                                            color: Colors.white,
                                          ))),
                                )),
                            Positioned(
                                top: 110,
                                bottom: 0,
                                width: Ruler.width(context, 70),
                                child: Center(
                                  child: Ruler.setText(
                                      UserModel.savedAccount!.name!,
                                      size: Ruler.setSize + 4,
                                      color: Colors.white,
                                      weight: FontWeight.w500),
                                )),
                            Positioned(
                              top: 0,
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/user_icon-icons.com_66546.svg',
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: Ruler.height(context, 35),
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
                                                    obscureText: sold,
                                                    controller: old,
                                                    onChanged: (value) {
                                                      setState(() {});
                                                      old.addListener(() {});
                                                    },
                                                    onFieldSubmitted: (value) {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              newNode);
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
                                                          const EdgeInsets
                                                                  .symmetric(
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
                                                              Ruler.setSize +
                                                                  1),
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
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
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
                                                          .requestFocus(
                                                              cnewNode);
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
                                                          const EdgeInsets
                                                                  .symmetric(
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
                                                              Ruler.setSize +
                                                                  1),
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
                                                          const EdgeInsets
                                                                  .symmetric(
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
                                                              Ruler.setSize +
                                                                  1),
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
                                          (newp.text.isNotEmpty &&
                                                  cnewp.text.isNotEmpty &&
                                                  newp.text != cnewp.text)
                                              ? Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
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
                                                  onTap: (newp.text
                                                              .isNotEmpty &&
                                                          newp.text ==
                                                              cnewp.text)
                                                      ? () async {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          Ruler
                                                              .showLoaderDialog(
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
                                                              .then(
                                                                  (value) async {
                                                            Ruler
                                                                .cancelLoaderDialog(
                                                                    context);
                                                            await Ruler
                                                                .writeAccount(
                                                                    value);
                                                            await Ruler
                                                                .readAccount();
                                                            Ruler.toastSuccess(
                                                                'Success');
                                                            Navigator.pop(
                                                                this.context);
                                                          }).onError((error,
                                                                  stackTrace) {
                                                            if (error
                                                                is DioError) {
                                                              if (error
                                                                      .response!
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
                                                    width: Ruler.width(
                                                        context, 65),
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                        color: (newp.text
                                                                    .isNotEmpty &&
                                                                newp.text ==
                                                                    cnewp.text)
                                                            ? Ruler.blueColor
                                                            : Ruler.greyColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Center(
                                                        child: Ruler.setText(
                                                            'Change password',
                                                            size:
                                                                Ruler.setSize +
                                                                    2,
                                                            color:
                                                                Colors.white)),
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
                ),
              ))
        ],
      ),
    );
  }
}
