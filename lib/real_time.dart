import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'model.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();

  List<user> userlist=[];
  DatabaseReference ref = FirebaseDatabase.instance.ref("student");//1-student
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(controller: t1,),
          TextField(controller: t2,),
          ElevatedButton(onPressed: () async{
            await ref.push().set({
              "name": "${t1.text}",
              "age": "${t2.text}",
            });
          }, child: Text("submit")),


          ElevatedButton(onPressed: () {
            DatabaseReference starCountRef = FirebaseDatabase.instance.ref('student');
            starCountRef.onValue.listen((DatabaseEvent event) {
              Map data = event.snapshot.value as Map;
              print(data);

              userlist.clear();
              data.forEach((key, value) {
                print("$key=>$value");
                user u=user.fromjson(value, key);
                userlist.add(u);
              });
              setState(() {

              });
            });
          }, child: Text("read")),

          Expanded(
            child: ListView.builder(itemCount: userlist.length,itemBuilder: (context, index) {
              return ListTile(
                title: Text("${userlist[index].name}"),
                subtitle: Text("${userlist[index].age}"),
                trailing: IconButton(onPressed: () async{
                  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('student/${userlist[index].key}');
                  await starCountRef.ref.remove();
                }, icon: Icon(Icons.delete)),
              );
            },),
          )
        ],
      ),
    );
  }
}
