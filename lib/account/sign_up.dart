import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:up_files/api/api_utils.dart';
import 'package:up_files/helper/ruler.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _tk = TextEditingController();
  final TextEditingController _mk = TextEditingController();
  final TextEditingController _cmk = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode tkNode = FocusNode();
  FocusNode mkNode = FocusNode();
  FocusNode cmkNode = FocusNode();
  bool hide = false;
  bool chide = false;
  String errMes = ' ';
  final api = APIUtils(Dio());

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Ruler.tealColor.withOpacity(0.8),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                    top: Ruler.height(context, 1),
                    bottom: Ruler.height(context, 1),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [

                          Opacity(
                              opacity: 0.1,
                              child: SvgPicture.asset(
                                'assets/Cyber attack-pana.svg',
                                width: Ruler.width(context, 95),
                              )),
                          SizedBox(
                            height: Ruler.height(context, 45),
                          ),
                        ],
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 40,
                            width: 40,
                            child: SvgPicture.asset('assets/back.svg'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Ruler.setText('SIGN UP',
                                  size: Ruler.setSize + 6,
                                  color: Colors.white,
                                  weight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                          width: 40,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _name,
                              focusNode: nameNode,
                              style: TextStyle(
                                  fontSize: Ruler.setSize + 2,
                                  color: Ruler.blackColor),
                              onChanged: (v) {
                                setState(() {
                                  errMes='';
                                  _name.addListener(() {});
                                });
                              },
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context).requestFocus(tkNode),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                label: Ruler.setText('Name',
                                    size: Ruler.setSize,
                                    color: Ruler.greyColor),
                                suffixIcon:
                                    _name.text.isEmpty || !nameNode.hasFocus
                                        ? const SizedBox()
                                        : GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              setState(() {
                                                _name.clear();
                                              });
                                            },
                                            child: Icon(
                                              Icons.clear,
                                              size: 22,
                                              color: Ruler.greyColor,
                                            ),
                                          ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            padding: const EdgeInsets.all(5),
                            child: SvgPicture.asset('assets/user.svg'),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _tk,
                              focusNode: tkNode,
                              style: TextStyle(
                                  fontSize: Ruler.setSize + 2,
                                  color: Ruler.blackColor),
                              onChanged: (v) {
                                setState(() {
                                  errMes='';
                                  _tk.addListener(() {});
                                });
                              },
                              keyboardType: TextInputType.phone,
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context).requestFocus(mkNode),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                label: Ruler.setText('Account',
                                    size: Ruler.setSize,
                                    color: Ruler.greyColor),
                                suffixIcon: _tk.text.isEmpty || !tkNode.hasFocus
                                    ? const SizedBox()
                                    : GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          setState(() {
                                            _tk.clear();
                                          });
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          size: 22,
                                          color: Ruler.greyColor,
                                        ),
                                      ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 32,
                            width: 32,
                            padding: const EdgeInsets.all(5),
                            child: SvgPicture.asset('assets/account.svg'),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _mk,
                              focusNode: mkNode,
                              obscureText: !hide,
                              style: TextStyle(
                                  fontSize: Ruler.setSize + 2,
                                  color: Ruler.blackColor),
                              onChanged: (v) {
                                setState(() { errMes='';
                                  _mk.addListener(() {});
                                });
                              },
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context).requestFocus(cmkNode),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                label: Ruler.setText('Password',
                                    size: Ruler.setSize,
                                    color: Ruler.greyColor),
                                suffixIcon: _mk.text.isEmpty || !mkNode.hasFocus
                                    ? const SizedBox()
                                    : GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          setState(() {
                                            _mk.clear();
                                          });
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          size: 22,
                                          color: Ruler.greyColor,
                                        ),
                                      ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              setState(() {
                                hide = !hide;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              padding: const EdgeInsets.all(5),
                              child: !hide
                                  ? SvgPicture.asset('assets/hide.svg')
                                  : SvgPicture.asset('assets/show.svg'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _cmk,
                              focusNode: cmkNode,
                              obscureText: !chide,
                              style: TextStyle(
                                  fontSize: Ruler.setSize + 2,
                                  color: Ruler.blackColor),
                              onChanged: (v) {
                                setState(() {
                                  errMes='';
                                });
                                if (v.isNotEmpty &&
                                    _mk.text.isNotEmpty &&
                                    v != _mk.text) {
                                  setState(() {
                                    errMes =
                                        'Confirm password incorrect';
                                  });
                                }
                              },
                              onFieldSubmitted: (v) async {
                                if (_name.text.isEmpty) {
                                  setState(() {
                                    errMes = 'Name can not be empty';
                                    FocusScope.of(context)
                                        .requestFocus(nameNode);
                                  });
                                } else if (_tk.text.isEmpty) {
                                  setState(() {
                                    errMes = 'Account can not be empty';
                                    FocusScope.of(context).requestFocus(tkNode);
                                  });
                                } else if (_mk.text.isEmpty) {
                                  setState(() {
                                    errMes = 'Password can not be empty';
                                    FocusScope.of(context).requestFocus(mkNode);
                                  });
                                } else if (_mk.text != _cmk.text) {
                                  setState(() {
                                    errMes =
                                        'Confirm password incorrect';
                                    FocusScope.of(context)
                                        .requestFocus(cmkNode);
                                  });
                                } else {
                                  Ruler.showLoaderDialog(context);
                                  await api
                                      .signUp(_tk.text, _mk.text, _name.text)
                                      .then((value) {
                                    Ruler.cancelLoaderDialog(context);
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.SCALE,
                                      headerAnimationLoop: true,
                                      dialogType: DialogType.SUCCES,
                                      dismissOnBackKeyPress: false,
                                      dismissOnTouchOutside: false,
                                      title: 'Sign up successfully',
                                      btnOkText: 'Sign  in',
                                      btnOkOnPress: () {
                                        Navigator.pop(context, [_tk.text, _mk.text]);
                                      },
                                    ).show();
                                  }).onError((error, stackTrace) {
                                    Ruler.cancelLoaderDialog(context);
                                    if(error is DioError){
                                    setState(() {
                                      errMes=error.response!.data!;
                                    });

                                    }
                                  });
                                }
                              },
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                label: Ruler.setText('Confirm password',
                                    size: Ruler.setSize,
                                    color: Ruler.greyColor),
                                suffixIcon: _mk.text.isEmpty || !mkNode.hasFocus
                                    ? const SizedBox()
                                    : GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          setState(() {
                                            _cmk.clear();
                                          });
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          size: 22,
                                          color: Ruler.greyColor,
                                        ),
                                      ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              setState(() {
                                chide = !chide;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              padding: const EdgeInsets.all(5),
                              child: !hide
                                  ? SvgPicture.asset('assets/hide.svg')
                                  : SvgPicture.asset('assets/show.svg'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Ruler.setText(errMes,
                          size: Ruler.setSize - 1, color: Ruler.redColor),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        if (_name.text.isEmpty) {
                          setState(() {
                            errMes = 'Name can not be empty';
                            FocusScope.of(context).requestFocus(nameNode);
                          });
                        } else if (_tk.text.isEmpty) {
                          setState(() {
                            errMes = 'Account can not be empty';
                            FocusScope.of(context).requestFocus(tkNode);
                          });
                        } else if (_mk.text.isEmpty) {
                          setState(() {
                            errMes = 'Password can not be empty';
                            FocusScope.of(context).requestFocus(mkNode);
                          });
                        } else if (_mk.text != _cmk.text) {
                          setState(() {
                            errMes = 'Confirm password incorrect';
                            FocusScope.of(context).requestFocus(cmkNode);
                          });
                        } else {
                          // AwesomeDialog(
                          //   context: context,
                          //   animType: AnimType.SCALE,
                          //   headerAnimationLoop: true,
                          //   dialogType: DialogType.SUCCES,
                          //   dismissOnBackKeyPress: false,
                          //   dismissOnTouchOutside: false,
                          //   title: 'Sign up successfully',
                          //   btnOkText: 'Sign in',
                          //   btnOkOnPress: () {
                          //     Navigator.pop(context, [_tk.text, _mk.text]);
                          //   },
                          // ).show();
                          Ruler.showLoaderDialog(context);
                          await api
                              .signUp(_tk.text, _mk.text, _name.text)
                              .then((value) {
                            Ruler.cancelLoaderDialog(context);
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              headerAnimationLoop: true,
                              dialogType: DialogType.SUCCES,
                              dismissOnBackKeyPress: false,
                              dismissOnTouchOutside: false,
                              title: 'Sign up successfully',
                              btnOkText: 'Sign  in',
                              btnOkOnPress: () {
                                Navigator.pop(context, [_tk.text, _mk.text]);
                              },
                            ).show();
                          }).onError((error, stackTrace) {
                            Ruler.cancelLoaderDialog(context);
                            if(error is DioError){
                              errMes=error.response!.data!;
                            }
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xff0a75ad),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Ruler.setText('Sign up',
                              size: Ruler.setSize + 2,
                              color: Colors.white,
                              weight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
