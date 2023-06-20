import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Box studentBox;
  TextEditingController textEditingController=TextEditingController();

  @override
  void initState() {
    studentBox= Hive.box('students') ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotePad'),
        actions: [InkWell(onTap: () {
          openBottomDialoge();
        }, child: Icon(Icons.add))],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('students').listenable(),
        builder: (context,box,widget) {

          return ListView.builder(
              itemCount: studentBox.keys.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(studentBox.getAt(index).toString()),
                );
              });
        }
      ),
    );
  }

  void openBottomDialoge() {
    showModalBottomSheet(context: context, builder: (_){
      return  Container(
        height: 100.0,
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
            ),
            ElevatedButton(onPressed: (){
              final textValue = textEditingController.text;
              studentBox.add(textValue);
              textEditingController.clear();
              Navigator.pop(context);
            }, child:const Text('Save Data'))
          ],
        ),
      );
    });

  }
}
