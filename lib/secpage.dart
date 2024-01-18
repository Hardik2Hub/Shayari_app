import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class sepag extends StatefulWidget {
  int index;
  List a;

  sepag(this.index, this.a);

  @override
  State<sepag> createState() => _sepagState();
}

class _sepagState extends State<sepag> {
  bool color_ra = true;
  String font_sty = "";
  Color col = Colors.pinkAccent;
  double b = 20;
  int pos1 = 0, pos2 = 1, po1 = 1;
  int mo = 0;
  bool font_col = false;
  Color font_color = Colors.black;
  List moj = [
    '😀 😃 😄 😁 😆',
    ' 😊 😇 🙂 🙃 😉',
    '😌 😍 🥰 😘 😗',
    '😙 😚 😋 😛 😝',
    '😜 🤪 🤨 🧐 🤓'
  ];
  List color = [
    Colors.green,
    Colors.red,
    Colors.indigo,
    Colors.grey,
    Colors.pinkAccent,
    Colors.redAccent,
    Colors.deepPurpleAccent,
    Colors.lightGreenAccent,
    Colors.deepOrangeAccent,
    Colors.limeAccent,
    Colors.lightBlueAccent,
    Colors.purpleAccent,
    Colors.brown,
    Colors.orangeAccent,
    Colors.teal,
    Colors.tealAccent,
    Colors.cyanAccent
  ];
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    get_permission();
  }

  get_permission() async {
    bool permissionStatus;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;

    if (deviceInfo.version.sdkInt > 32) {
      permissionStatus = await Permission.photos.request().isGranted;
    } else {
      permissionStatus = await Permission.storage.request().isGranted;
    }
  }

  @override
  Widget build(BuildContext context) {
    double sc = MediaQuery.of(context).size.height;
    double at = MediaQuery.of(context).padding.top;
    double ap = kToolbarHeight;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text("Shayari"),
            centerTitle: true,
            backgroundColor: Colors.pink),
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  Expanded(
                    child: WidgetsToImage(
                      controller: controller,
                      child: Container(
                        height: 300,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: (color_ra == true) ? col : null,
                          gradient: (color_ra == false)
                              ? LinearGradient(
                                  colors: [color[pos1], color[pos2]])
                              : null,
                        ),
                        child: Text(
                            "${moj[mo]}${widget.a[widget.index]}${moj[mo]}",
                            style: TextStyle(
                                fontFamily: "$font_sty",
                                fontSize: b,
                                color: font_color)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 80),
                    color: Colors.brown,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              width: 100,
                              height: 50,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Color(color.length);
                                      color_ra = false;
                                      color.shuffle();
                                      setState(() {});
                                    },
                                    child: Image.asset(
                                        "myasset/image/shayari/reload.png",
                                        width: 40,
                                        height: 40),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        barrierColor: Colors.transparent,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: sc - at - ap - 10,
                                            child: GridView.builder(
                                              itemCount: color.length - 1,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 10,
                                                      crossAxisSpacing: 10),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    pos1 = index;
                                                    pos2 = index + 1;
                                                    color_ra = false;
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text("Shayari",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color:
                                                                Colors.white)),
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                          color[index],
                                                          color[index + 1]
                                                        ])),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Image.asset(
                                        "myasset/image/shayari/expand.png",
                                        width: 40,
                                        height: 40),
                                  ),
                                ],
                              )),
                        ]),
                  ))
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.brown,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                isDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: sc - at - ap - 565,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GridView.builder(
                                            itemCount: color.length - 1,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 8,
                                                ),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  color_ra = true;
                                                  col = color[index];
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 100,width: 100,
                                                  margin: EdgeInsets.only(top: 12,left: 10),
                                                  alignment: Alignment.center,
                                                  color: color[index],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Image.asset(scale: 2,
                                                  "myasset/image/shayari/close.png")),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 50,
                              width: 100,
                              child: Text("Background",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              alignment: Alignment.center,
                              color: Colors.red,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                isDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: sc - at - ap - 565,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GridView.builder(
                                            itemCount: color.length - 1,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 8,
                                               ),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  font_color = color[index];
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 12,left: 10),
                                                  alignment: Alignment.center,
                                                  color: color[index],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Image.asset(scale: 2,
                                                  "myasset/image/shayari/close.png")),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 50,
                              width: 100,
                              child: Text("Text Color",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              alignment: Alignment.center,
                              color: Colors.red,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              bytes = await controller.capture();
                              var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS) + "/RHM";
                              Directory dir = Directory(path);
                              if (!await dir.exists())
                              {
                                dir.create();
                              }
                              String img_name = "${Random().nextInt(1000)}myimg.jpg";
                              File file = File("${dir.path}/${img_name}");
                              file.writeAsBytes(bytes!);
                              Share.shareFiles(['${file.path}']);
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 50,
                              width: 100,
                              child: Text("Share",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              alignment: Alignment.center,
                              color: Colors.red,
                            ),
                          ),
                        ]),
                  ))
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.brown,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                isDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Container(height: sc - at - ap - 565,child: Row(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                                color: Colors.transparent,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                      child: InkWell(
                                                          onTap: () {
                                                            font_sty = "one";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width: 100,
                                                            color: Colors.pink,
                                                            child: Text(
                                                                "shayri",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "one",
                                                                    fontSize:
                                                                    15)),
                                                          )),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                      child: InkWell(
                                                          onTap: () {
                                                            font_sty = "two";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width: 100,
                                                            color: Colors.pink,
                                                            child: Text("two",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "two",
                                                                    fontSize:
                                                                    15)),
                                                          )),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                      child: InkWell(
                                                          onTap: () {
                                                            font_sty = "three";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width: 100,
                                                            color: Colors.pink,
                                                            child: Text("three",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "three",
                                                                    fontSize:
                                                                    15)),
                                                          )),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                      child: InkWell(
                                                          onTap: () {
                                                            font_sty = "four";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width: 100,
                                                            color: Colors.pink,
                                                            child: Text("four",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "four",
                                                                    fontSize:
                                                                    15)),
                                                          )),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                      child: InkWell(
                                                          onTap: () {
                                                            font_sty = "five";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width: 100,
                                                            color: Colors.pink,
                                                            child: Text("five",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "five",
                                                                    fontSize:
                                                                    15)),
                                                          )),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                      child: InkWell(
                                                          onTap: () {
                                                            font_sty = "six";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width: 100,
                                                            color: Colors.pink,
                                                            child: Text("six",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "six",
                                                                    fontSize:
                                                                    15)),
                                                          )),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                      child: InkWell(
                                                          onTap: () {
                                                            font_sty = "seven";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width: 100,
                                                            color: Colors.pink,
                                                            child: Text("seven",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "seven",
                                                                    fontSize:
                                                                    15)),
                                                          )),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10),
                                                      child: InkWell(
                                                          onTap: () {
                                                            font_sty = "eight";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width: 100,
                                                            color: Colors.pink,
                                                            child: Text("eight",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "eight",
                                                                    fontSize:
                                                                    15)),
                                                          )),
                                                    ),
                                                    // InkWell(onTap: () {font_styyle="one";Navigator.pop(context);setState(() {});},child: Container(height: 50,width: 100,color: Colors.grey,child: Text("",style: TextStyle(fontFamily: "one")),)),
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Image.asset(scale: 2,
                                                "myasset/image/shayari/close.png")),
                                      ),
                                    ],
                                  ),);
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 50,
                              width: 100,
                              child: Text("Font",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              alignment: Alignment.center,
                              color: Colors.red,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                isDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: sc - at - ap - 480,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: moj.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: ListTile(
                                                  onTap: () {
                                                    mo = index;
                                                    setState(() {});
                                                  },
                                                  tileColor: Colors.red[50],
                                                  title: Center(child: Text("${moj[index]}")),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Image.asset(scale: 2,
                                                  "myasset/image/shayari/close.png")),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 50,
                              width: 100,
                              child: Text("Emoji",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              alignment: Alignment.center,
                              color: Colors.red,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                isDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: sc - at - ap - 565,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: StatefulBuilder(
                                            builder: (context, setState1) {
                                              return Slider(
                                                min: 0,
                                                max: 100,
                                                value: b,
                                                onChanged: (value) {
                                                  b = value;
                                                  setState(() {});
                                                  setState1(() {});
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Image.asset(scale: 2,
                                                  "myasset/image/shayari/close.png")),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 50,
                              width: 100,
                              child: Text("Text Size",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              alignment: Alignment.center,
                              color: Colors.red,
                            ),
                          ),
                        ]),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
