import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shayari/second.dart';
import 'Data.dart';

void main() {
  runApp(MaterialApp(
    home: sayi(),
    debugShowCheckedModeBanner: false,
  ));
}

class sayi extends StatefulWidget {
  @override
  State<sayi> createState() => _sayiState();
}

class _sayiState extends State<sayi> {
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

  List<bool> temp = List.filled(Data.arr.length, false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shayari"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: ListView.separated(
          itemCount: Data.arr.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index < Data.arr.length) {
                  temp[index] = true;
                }
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return second(index, Data.arr, Data.img);
                  },
                ));
                setState(() {});
                temp[index] = false;
              },
              onTapDown: (details) {
                temp[index] = true;
                setState(() {});
              },
              onTapCancel: () {
                temp[index] = false;
                setState(() {});
              },
              child: Card(
                child: ListTile(
                  tileColor: (temp[index] == true) ? Colors.pink : null,
                  trailing: (temp[index] == true)
                      ? Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                        )
                      : null,
                  leading: Image.asset("${Data.img[index]}"),
                  title: Text("${Data.arr[index]}"),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 5,
              thickness: 0,
              color: Colors.transparent,
            );
          },
        ),
      ),
    );
  }
}
