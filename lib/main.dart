import 'package:demoapp/provider/add_color.dart';
import 'package:demoapp/provider/model.dart';
import 'package:demoapp/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddColor(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  int colorcode = 0xff000000;

  TextEditingController pointerValueController = TextEditingController();
  TextEditingController ValueController = TextEditingController();
  TextEditingController TitleController = TextEditingController();
  TextEditingController colorValueController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Center(
            child: const Text('Add UI', style: TextStyle(color: Colors.blue))),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Pointer Value :',
                  style: const TextStyle(color: Colors.black),
                ),
                Container(
                  height: 35,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: pointerValueController,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      hintText: 'Pointer Value',
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  if (ValueController.text.isNotEmpty &&
                      TitleController.text.isNotEmpty) {
                    context.read<AddColor>().addRow(ColorRow(
                          ValueController.text,
                          TitleController.text,
                          colorcode,
                        ));
                    ValueController.clear();

                    TitleController.clear();
                    colorValueController.clear();
                    setState(() {
                      colorcode = 0xff000000;
                    });
                  }
                },
                child: const Text('Click here to add slots below',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    )),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: ValueController,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          hintText: 'Value',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        controller: TitleController,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 85,
                      decoration: BoxDecoration(
                        color: Color(colorcode),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          if (colorValueController.text.length >= 6) {
                            setState(() {
                              colorcode =
                                  int.parse('0xff' + colorValueController.text);
                            });
                          }
                        },
                        controller: colorValueController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '#000000',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(Icons.close)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('color value must be  6  integer digit like 436788'),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: context.watch<AddColor>().items.length,
                      itemBuilder: (context, index) {
                        var items = context.read<AddColor>().items;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: Text(items[index].value),
                            ),
                            Container(
                              height: 30,
                              width: 170,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: Text(items[index].title),
                            ),
                            Container(
                              height: 30,
                              width: 85,
                              decoration: BoxDecoration(
                                color: Color(items[index].colorcode),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                                onTap: () {
                                  context.read<AddColor>().deleteRow(index);
                                },
                                child: const Icon(Icons.close))
                          ],
                        );
                      }),
                )
              ],
            ),
            const Spacer(
              flex: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                  onPressed: () {
                    if (pointerValueController.text.isNotEmpty) {
                      context
                          .read<AddColor>()
                          .addData(int.parse(pointerValueController.text));
                      pointerValueController.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ColorsScreen()),
                      );
                    }
                  },
                  child: const Text('Add')),
            ),
          ],
        ),
      ),
    );
  }
}
