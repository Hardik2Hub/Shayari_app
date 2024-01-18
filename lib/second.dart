import 'package:flutter/material.dart';
import 'package:shayari/Data.dart';
import 'package:shayari/pagevi.dart';

class second extends StatefulWidget {
  int index;
  List arr;
  List img;

  second(this.index, this.arr, this.img);

  @override
  State<second> createState() => _secondState();
}

List a = [];

class _secondState extends State<second> {
  @override
  void initState() {
    super.initState();

    switch (widget.index) {
      case 0:
        a = Data.one;
        break;

      case 1:
        a = Data.two;
        break;

      case 2:
        a = Data.three;
        break;

      case 3:
        a = Data.four;
        break;

      case 4:
        a = Data.five;
        break;

      case 5:
        a = Data.six;
        break;

      case 6:
        a = Data.seven;
        break;

      case 7:
        a = Data.eight;
        break;

      case 8:
        a = Data.nine;
        break;

      case 9:
        a = Data.ten;
        break;

      case 10:
        a = Data.eleven;
        break;

      case 11:
        a = Data.twe;
        break;

      case 12:
        a = Data.thi;
        break;

      case 13:
        a = Data.fou;
        break;

      case 14:
        a = Data.fif;
        break;

      case 15:
        a = Data.sixt;
        break;

      case 16:
        a = Data.sev;
        break;
    }
  }

  List<bool> te = List.filled(Data.arr.length, false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text("${widget.arr[widget.index]}"),
            centerTitle: true,
            backgroundColor: Colors.yellow),
        body: ListView.builder(
          itemCount: a.length,
          itemBuilder: (context, index) {
            return Card(
                child: GestureDetector(
              onTap: () {
                if (index < Data.arr.length) {
                  te[index] = true;
                }
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return pagevi(index, a);
                  },
                ));
                setState(() {});
                te[index] = false;
              },
              onTapDown: (details) {
                te[index] = true;
                setState(() {});
              },
              onTapCancel: () {
                te[index] = false;
                setState(() {});
              },
              child: ListTile(
                title: Text("${a[index]}",
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                leading: Image.asset("${widget.img[widget.index]}"),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.indigo,
                ),
                tileColor: (te[index] == true) ? Colors.pink : null,
              ),
            ));
          },
        ),
      ),
    );
  }
}
