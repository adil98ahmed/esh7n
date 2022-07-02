import 'package:esh7n/screens/etisalat_options.dart';
import 'package:esh7n/screens/orange_options.dart';
import 'package:esh7n/screens/vodafone_options.dart';
import 'package:esh7n/screens/we_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool? rotated;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop),
                image: AssetImage('images/b9.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0,
                              MediaQuery.of(context).size.height * .03,
                              0,
                              MediaQuery.of(context).size.height * .05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          .01),
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.8),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: (Colors.grey[300])!,
                                          blurRadius: 10.0,
                                        )
                                      ]),
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VodafoneOptions(
                                                  color: Colors.red,
                                                )),
                                      );
                                    },
                                    child: ClipRRect(
                                      child: Image(
                                        height:
                                            (MediaQuery.of(context).size.width >
                                                        0 &&
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        576)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .40
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .32,
                                        width:
                                            (MediaQuery.of(context).size.width >
                                                        0 &&
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        576)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .40
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .32,
                                        image: AssetImage('images/v.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          .01),
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.8),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: (Colors.grey[300])!,
                                          blurRadius: 10.0,
                                        )
                                      ]),
                                  child: GestureDetector(
                                    onTap: () async {
                                      //await launch('tel:#');

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EtisalatOptions(
                                                  color: Colors.red,
                                                )),
                                      );
                                    },
                                    child: ClipRRect(
                                      child: Image(
                                        height:
                                            (MediaQuery.of(context).size.width >
                                                        0 &&
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        576)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .40
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .32,
                                        width:
                                            (MediaQuery.of(context).size.width >
                                                        0 &&
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        576)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .40
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .32,
                                        image: AssetImage('images/e.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * .04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          .01),
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * .025,
                                      MediaQuery.of(context).size.width * .02,
                                      MediaQuery.of(context).size.width * .025,
                                      MediaQuery.of(context).size.width * .02),
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.8),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: (Colors.grey[300])!,
                                          blurRadius: 10.0,
                                        )
                                      ]),
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OrangeOptions(
                                                  color: Colors.red,
                                                )),
                                      );
                                    },
                                    child: ClipRRect(
                                      child: Image(
                                        height:
                                            (MediaQuery.of(context).size.width >
                                                        0 &&
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        576)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .40
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .32,
                                        width:
                                            (MediaQuery.of(context).size.width >
                                                        0 &&
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        576)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .30
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .22,
                                        image: AssetImage('images/o.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          .01),
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.8),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: (Colors.grey[300])!,
                                          blurRadius: 10.0,
                                        )
                                      ]),
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WeOptions(
                                                  color: Colors.red,
                                                )),
                                      );
                                    },
                                    child: ClipRRect(
                                      child: Image(
                                        height:
                                            (MediaQuery.of(context).size.width >
                                                        0 &&
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        576)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .40
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .32,
                                        width:
                                            (MediaQuery.of(context).size.width >
                                                        0 &&
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        576)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .40
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .32,
                                        image: AssetImage('images/w.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
