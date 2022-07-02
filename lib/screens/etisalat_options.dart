import 'package:esh7n/providers/dialog_provider.dart';
import 'package:esh7n/providers/etisalat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';

class EtisalatOptions extends StatefulWidget {
  final Color? color;
  const EtisalatOptions({Key? key, this.color}) : super(key: key);

  @override
  _EtisalatOptionsState createState() => _EtisalatOptionsState();
}

class _EtisalatOptionsState extends State<EtisalatOptions> {
  Future<void> takeAction() async {
    var option = await context.read<AlertDialogProvider>().getPreference();
    if (option == null) {
      showMyDialog();
    } else {
      await context.read<EtisalatProvider>().takePhoto(option);
      showCircularBar();
      await context.read<EtisalatProvider>().readTextFromImage();
      Navigator.of(context).pop();
      if (context.read<EtisalatProvider>().flag == true) {
        showFail();
      } else {
        showCopyOrCall();
      }
    }
  }

  Future<void> oneTime() async {
    var option = context.read<AlertDialogProvider>().option;
    if (option != '') {
      print('xxxxxxxxxxxxxxxxxxxxxxxxx');
      await context.read<EtisalatProvider>().takePhoto(option);
      showCircularBar();
      await context.read<EtisalatProvider>().readTextFromImage();
      Navigator.of(context).pop();
      if (context.read<EtisalatProvider>().flag == false) {
        Navigator.of(context).pop();
        showCopyOrCall();
      }

      if (context.read<EtisalatProvider>().flag == true) {
        Navigator.of(context).pop();
        await showFail();
      }
    }
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              alignment: Alignment.topRight,
              child: Text('صورة الكارت', style: TextStyle(fontSize: 17))),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<AlertDialogProvider>(
                  builder: (context, value, child) => Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          value.setCurrentOption('camera');
                        },
                        onDoubleTap: () {
                          value.setCurrentOption('camera');
                          oneTime();
                        },
                        child: Container(
                            padding: EdgeInsets.all(15),
                            color: (value.option == 'camera')
                                ? Colors.blue[50]
                                : Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                                Text(
                                  'الكاميرا',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )),
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          value.setCurrentOption('gallery');
                        },
                        onDoubleTap: () {
                          value.setCurrentOption('gallery');
                          oneTime();
                        },
                        child: Container(
                            padding: EdgeInsets.all(15),
                            color: (value.option == 'gallery')
                                ? Colors.blue[50]
                                : Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.panorama_rounded,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                                Text(
                                  'المعرض',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'دائما',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () async {
                var option = context.read<AlertDialogProvider>().option;
                await context
                    .read<AlertDialogProvider>()
                    .setDefaultOption(option);
                oneTime();
              },
            ),
            TextButton(
              child: const Text(
                'مرة واحدة',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () async {
                oneTime();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showCircularBar() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Builder(
            builder: (_) => Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '...انتظر جاري قراءة الكود',
                        style: TextStyle(color: Colors.grey[800], fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showFail() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Builder(
            builder: (_) => Container(
              height: MediaQuery.of(context).size.height * .05,
              alignment: Alignment.bottomRight,
              child: Text(
                'غير قادر على قراءة كود الشحن',
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('اعد المحاولة'))
          ],
        );
      },
    );
  }

  Future<void> showOk() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Builder(
            builder: (_) => Container(
              height: MediaQuery.of(context).size.height * .05,
              alignment: Alignment.bottomRight,
              child: Text(
                'تم اعادة ضبط اعدادات الإختيار',
                style: TextStyle(
                    color: Color.fromRGBO(34, 87, 126, 1), fontSize: 15),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('موافق'))
          ],
        );
      },
    );
  }

  Future<void> showCopyDone() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Builder(
            builder: (_) => Container(
              height: MediaQuery.of(context).size.height * .05,
              alignment: Alignment.bottomRight,
              child: Text(
                'تم نسخ كود الشحن',
                style: TextStyle(
                    color: Color.fromRGBO(34, 87, 126, 1), fontSize: 13),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('موافق'))
          ],
        );
      },
    );
  }

  Future<void> showCopyOrCall() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  FlutterClipboard.copy(
                      context.read<EtisalatProvider>().copyCode());
                  Navigator.of(context).pop();
                  showCopyDone();
                },
                child: Text('نسخ الكود')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  FlutterPhoneDirectCaller.callNumber(
                      context.read<EtisalatProvider>().code);
                },
                child: Text('اتصال'))
          ],
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Builder(
            builder: (_) {
              var code = context.read<EtisalatProvider>().code;
              return Container(
                  child: Text(
                code,
                style: TextStyle(fontSize: 14),
              ));
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              await context.read<AlertDialogProvider>().deletePreference();
              showOk();
            },
            itemBuilder: (BuildContext context) {
              return ['اعادة ضبط البرنامج'].map((dynamic choice) {
                return PopupMenuItem<String>(
                    value: choice,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          choice,
                        ),
                      ],
                    ));
              }).toList();
            },
          )
        ],
        backgroundColor: Color.fromRGBO(34, 87, 126, 1),
        title: Text('Etisalat'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'images/b9.jpg',
                ),
                fit: BoxFit.cover)),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.white.withOpacity(.5)),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Image(
                    height: 150,
                    image: AssetImage('images/e.png'),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * .05),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: (Colors.grey[100])!,
                                blurRadius: 20.0,
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () async {
                            context
                                .read<EtisalatProvider>()
                                .chooseOption('*556*');
                            await takeAction();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(.8)),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * .8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'رصيد -  كارت فكـة',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                                Text(
                                  '* 556 *  كود الشحن #',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: (Colors.grey[100])!,
                                blurRadius: 20.0,
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () async {
                            context
                                .read<EtisalatProvider>()
                                .chooseOption('*556*1*');
                            await takeAction();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(.8)),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * .8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'ميكســات',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                                Text(
                                  '* 556 * 1 *  كود الشحن #',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: (Colors.grey[100])!,
                                blurRadius: 20.0,
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () async {
                            context
                                .read<EtisalatProvider>()
                                .chooseOption('*556*2*');
                            await takeAction();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(.8)),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * .8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'دقـائـق',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                                Text(
                                  '* 556 * 2 *  كود الشحن #',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: (Colors.grey[100])!,
                                blurRadius: 20.0,
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () async {
                            context
                                .read<EtisalatProvider>()
                                .chooseOption('*556*3*');
                            await takeAction();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(.8)),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * .8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'ميجـابايتـس',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                                Text(
                                  '* 556 * 3 *  كود الشحن #',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: (Colors.grey[100])!,
                                blurRadius: 20.0,
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () async {
                            context
                                .read<EtisalatProvider>()
                                .chooseOption('*556*5*');
                            await takeAction();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(.8)),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * .8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'نت سوشيـال',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                                Text(
                                  '* 556 * 5 *   كود الشحن #',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: (Colors.grey[100])!,
                                blurRadius: 20.0,
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () async {
                            context
                                .read<EtisalatProvider>()
                                .chooseOption('*556*7*');
                            await takeAction();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(.8)),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * .8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'نت فيديـو',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                                Text(
                                  '* 556 * 7 *   كود الشحن #',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: (Colors.grey[100])!,
                                blurRadius: 20.0,
                              )
                            ]),
                        child: ElevatedButton(
                          onPressed: () async {
                            context
                                .read<EtisalatProvider>()
                                .chooseOption('*322*');
                            await takeAction();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(.8)),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * .8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'لشحن الكارت مرة اخرى',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                                Text(
                                  '* 322 *   كود الشحن #',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(34, 87, 126, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
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
