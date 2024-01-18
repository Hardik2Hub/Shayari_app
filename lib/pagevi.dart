import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari/secpage.dart';

class pagevi extends StatefulWidget {
  int index;
  List a;

  pagevi(this.index, this.a);

  @override
  State<pagevi> createState() => _pageviState();
}

class _pageviState extends State<pagevi> {
  PageController? controller;

  bool color_st = false;
  int pos1 = 0, pos2 = 1;
  List col = [
    Colors.amberAccent,
    Colors.teal,
    Colors.brown,
    Colors.purpleAccent,
    Colors.blue,
    Colors.deepOrangeAccent,
    Colors.lightGreen,
    Colors.indigo,
    Colors.red,
    Colors.tealAccent,
    Colors.pink
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    double sc = MediaQuery.of(context).size.height;
    double at = MediaQuery.of(context).padding.top;
    double ap = kToolbarHeight;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: Text("Shayaari"),
              centerTitle: true,
              backgroundColor: Colors.red),
          body: Column(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                                itemCount: col.length - 1,
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
                                      color_st = true;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text("Shayari",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white)),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                        col[index],
                                        col[index + 1]
                                      ])),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Image.asset("myasset/image/shayari/expand.png",
                          width: 40, height: 40)),
                  Text(
                    "${widget.index + 1}/${widget.a.length}",
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                      onTap: () {
                        Color(col.length);
                        col.shuffle();
                        color_st = true;
                        setState(() {});
                      },
                      child: Image.asset("myasset/image/shayari/reload.png",
                          width: 40, height: 40)),
                ],
              )),
              Expanded(
                flex: 4,
                child: PageView.builder(
                  onPageChanged: (value) {
                    widget.index = value;
                    setState(() {});
                  },
                  controller: controller,
                  itemCount: widget.a.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (color_st == false) ? Colors.red : null,
                        gradient: (color_st == true)
                            ? LinearGradient(colors: [col[pos1], col[pos2]])
                            : null,
                      ),
                      child: Text(widget.a[index],
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                color: Colors.green,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: "${widget.a[widget.index]}"));
                          },
                          icon: Icon(Icons.copy)),
                      IconButton(
                          onPressed: () {
                            if (widget.index != 0) {
                              widget.index--;
                              controller!.jumpToPage(widget.index);
                              setState(() {});
                            }
                          },
                          icon: Icon(Icons.arrow_back_ios_new_sharp)),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return sepag(widget.index, widget.a);
                              },
                            ));
                          },
                          child: Image.asset("myasset/image/shayari/pencil.png",
                              width: 30, height: 30)),
                      IconButton(
                          onPressed: () {
                            if (widget.index < widget.a.length - 1) {
                              widget.index++;
                              controller!.jumpToPage(widget.index);
                              setState(() {});
                            }
                          },
                          icon: Icon(Icons.arrow_forward_ios_sharp)),
                      IconButton(
                          onPressed: () {
                            Share.share("${widget.a[widget.index]}");
                          },
                          icon: Icon(Icons.share)),
                    ]),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          )),
    );
  }
}
