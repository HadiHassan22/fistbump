import 'package:fistbump/models/profile_model.dart';
import 'package:fistbump/screens/professional_profile_page.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  final Function callback;
  ListPage({Key? key, required this.callback}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.callback(),
        builder: (context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    "Explore",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) => ListTile(
                          title: Text("${snapshot.data![i].name}"),
                          subtitle: Text("${snapshot.data![i].location}"),
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfessionalProfilePage(
                                        profile: snapshot.data![i],
                                      ))),
                        )));
          } else {
            print(snapshot.connectionState);
            print(snapshot.hasData);
            print(snapshot.hasError);
            print(snapshot.error);
            return Center(
                child: CircularProgressIndicator(
                  // backgroundColor: Colors.orange,
            ));
          }
        });
  }
}
