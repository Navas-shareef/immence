import 'dart:ui';

import 'package:demoapp/main.dart';
import 'package:demoapp/provider/add_color.dart';
import 'package:demoapp/provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ColorsScreen extends StatefulWidget {
  const ColorsScreen({Key? key}) : super(key: key);

  @override
  State<ColorsScreen> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Items> item = context.read<AddColor>().data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            const Text('Immence', style: TextStyle(color: Colors.blue)),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.red,
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ListView.separated(
            itemBuilder: (context, index) {
              int count = item[index].colorRow.length;

              int colorName = 0xf0000000;
              for (int i = 0; i < item[index].colorRow.length; i++) {
                if (int.parse(item[index].colorRow[i].value) >=
                    item[index].pointerValue) {
                  colorName = item[index].colorRow[i].colorcode;

                  break;
                } else {
                  colorName = 0xff565756;
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: item[index].colorRow.map((e) {
                      int loc = item[index].colorRow.indexOf(e);
                      bool isAvailable = false;

                      if (loc != 0) {
                        double width = (int.parse(e.value) -
                                int.parse(
                                    item[index].colorRow[loc - 1].value)) /
                            int.parse(item[index].colorRow[count - 1].value) *
                            (MediaQuery.of(context).size.width - 40);

                        isAvailable =
                            int.parse(item[index].colorRow[loc - 1].value) >=
                                    item[index].pointerValue
                                ? true
                                : false;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            int.parse(e.value) >= item[index].pointerValue &&
                                    isAvailable == false
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 3, left: 0),
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Color(colorName),
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                : const SizedBox(),
                            Container(
                              width: width,
                              height: 35,
                              child: Center(
                                child: Text(
                                  e.title,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              color: Color(e.colorcode),
                            ),
                          ],
                        );
                      } else {
                        double width = int.parse(e.value) /
                            int.parse(item[index].colorRow[count - 1].value) *
                            (MediaQuery.of(context).size.width - 40);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            int.parse(e.value) >= item[index].pointerValue
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 3, left: 0),
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Color(colorName),
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                : const SizedBox(),
                            Container(
                              width: width,
                              height: 35,
                              child: Center(
                                child: Text(
                                  e.title,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              color: Color(e.colorcode),
                            ),
                          ],
                        );
                      }
                    }).toList()),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: context.watch<AddColor>().data.length,
          ),
        ),
      ),
    );
  }
}
