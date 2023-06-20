import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late Box studentBox;
  TextEditingController textEditingController=TextEditingController();

  @override
  void initState() {
    studentBox=Hive.box('students');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Database'),
        actions: [
          InkWell(
            onTap: (){
              showDialoge();
            },
            child: Icon(
              Icons.add
            ),
          )
        ],
      ),

      body: ValueListenableBuilder(
        valueListenable: Hive.box('students').listenable(),
        builder: (context,box,widget){
          return ListView.builder(
              itemCount: studentBox.keys.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(studentBox.getAt(index).toString()),
                );
              });
        },
      ),




    );
  }

  showDialoge(){
    showModalBottomSheet(context: context, builder: (builder){
      return Column(
        children: [
          TextField(
            controller: textEditingController,
          ),

          SizedBox(height: 10.0),

          ElevatedButton(onPressed: (){
            studentBox.add(textEditingController.text);
            textEditingController.clear();
            Navigator.pop(context);

          }, child: Text('Submit'))

        ],
      );

    });
  }

}
