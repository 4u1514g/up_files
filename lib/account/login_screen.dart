import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:up_files/account/sign_up.dart';
import 'package:up_files/api/api_utils.dart';
import 'package:up_files/helper/bottom_bar.dart';
import 'package:up_files/helper/ruler.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  Future? _future;

  @override
  void initState() {
    super.initState();
    _future = Ruler.readAccount();
  }

  @override
  Widget build(BuildContext context) {
    Ruler().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (snapshot.data != null) {
            Future.delayed(const Duration(milliseconds: 10), () {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => const BotNavBar()),
                  (route) => false);
            });
            return  Container();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _tk = TextEditingController();
  final TextEditingController _mk = TextEditingController();
  FocusNode tkNode = FocusNode();
  FocusNode mkNode = FocusNode();
  final api = APIUtils(Dio());
  bool hide = false;
  String errMes = '';

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: const Color(0xffACABD3).withOpacity(0.8),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: Ruler.height(context, 5)),
                  height: Ruler.height(context, 25),
                  width: Ruler.height(context, 25),
                  decoration: const BoxDecoration(
                      color: Color(0xff9a9bcb), shape: BoxShape.circle),
                  padding: EdgeInsets.all(Ruler.height(context, 2)),
                  child: Opacity(
                      opacity: 0.8,
                      child: SvgPicture.asset('assets/Folder-pana.svg')),
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
                          controller: _tk,
                          focusNode: tkNode,
                          style: TextStyle(
                              fontSize: Ruler.setSize + 2,
                              color: Ruler.blackColor),
                          onChanged: (v) {
                            setState(() {
                              errMes = '';
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
                            hintText: 'Account',
                            hintStyle: TextStyle(
                                fontSize: Ruler.setSize + 1,
                                color: Ruler.greyColor),
                            suffixIcon: _tk.text.isEmpty || !tkNode.hasFocus
                                ? const SizedBox()
                                : GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      setState(() {
                                        errMes = '';
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
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _mk,
                          focusNode: mkNode,
                          style: TextStyle(
                              fontSize: Ruler.setSize + 2,
                              color: Ruler.blackColor),
                          onChanged: (v) {
                            setState(() {
                              errMes = '';
                              _mk.addListener(() {});
                            });
                          },
                          onFieldSubmitted: (mk) async {
                            if (mk.isNotEmpty && _tk.text.isNotEmpty) {
                              Ruler.showLoaderDialog(context);
                              await api.signIn(_tk.text, mk).then((value) async{
                                Ruler.cancelLoaderDialog(context);
                                await Ruler.writeAccount(value);
                                await Ruler.readAccount();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const BotNavBar()),
                                    (route) => false);
                              }).onError((error, stackTrace) {
                                Ruler.cancelLoaderDialog(context);
                                if (error is DioError) {
                                  setState(() {
                                    errMes = 'wrong phone or password';
                                  });
                                }
                              });
                            }
                          },
                          obscureText: !hide,
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontSize: Ruler.setSize + 1,
                                color: Ruler.greyColor),
                            suffixIcon: _mk.text.isEmpty || !mkNode.hasFocus
                                ? const SizedBox()
                                : GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      setState(() {
                                        errMes = '';
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
                  child: Ruler.setText(errMes,
                      size: Ruler.setSize, color: Ruler.redColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _mk.text.isNotEmpty && _tk.text.isNotEmpty
                      ? () async {
                          await api.signIn(_tk.text, _mk.text).then((value) async{
                              Ruler.cancelLoaderDialog(context);
                              await Ruler.writeAccount(value);
                              await Ruler.readAccount();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const BotNavBar()),
                                  (route) => false);
                            }).onError((error, stackTrace) {
                              if (error is DioError) {
                                Ruler.cancelLoaderDialog(context);
                                setState(() {
                                  errMes = 'wrong phone or password';
                                });
                              }
                            });
                    Navigator.push(context,CupertinoPageRoute(builder: (context) =>const BotNavBar()));
                        }
                      : null,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: _mk.text.isNotEmpty && _tk.text.isNotEmpty
                            ? Ruler.blueColor
                            : Ruler.greyColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Ruler.setText('SIGN IN',
                            size: Ruler.setSize +2, color: Colors.white,weight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(height: 4,),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Ruler.setText('--- or ---', size: Ruler.setSize - 1),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async=>await Navigator.push(context,CupertinoPageRoute(builder: (context) =>const SignUp())).then((value) {
                    if(value!=null){
                      setState(() {
                        _tk.text=value[0];
                        _mk.text=value[1];
                      });
                    }
                  }),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Ruler.setText('SIGN UP', size: Ruler.setSize + 2, weight: FontWeight.w500,color: Ruler.blueColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
