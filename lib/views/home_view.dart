import 'package:flutter/material.dart';
import 'package:ids/models/constants_model.dart';
import 'package:ids/repositories/account_repository.dart';
import 'package:ids/view-models/people_viewmodel.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AccountRepository _repository = AccountRepository();
  PeopleViewModel _peopleViewModel = PeopleViewModel();
  bool _busy = true;
  List allPeoples = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(
          Duration(seconds: 3),
          () async =>
              await _repository.getAllPeoples().then((listAllPeoples) async {
                allPeoples = listAllPeoples;
                setState(() {
                  _busy = false;
                });
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Pessoas"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              print(allPeoples[1].name);
              // await _repository.getAllPeoples().then((listAllPeoples) {
              //   print(listAllPeoples);
              // });
              // await _repository.getAllPeoples().then((value) => print(value));
            },
            icon: Icon(Icons.ac_unit),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          color: Colors.grey[300],
          child: ListView.separated(
              separatorBuilder: (_, index) => Divider(),
              itemCount: allPeoples.length,
              itemBuilder: (_, index) {
                _peopleViewModel =
                    PeopleViewModel(peopleModel: allPeoples[index]);
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (modalContext) {
                          return Container(
                            height: constraints.maxHeight * .15,
                            // color: Colors.amber,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: Colors.blue[900],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: ListTile(
                    title: Text(
                      _peopleViewModel.name ?? "Fulano",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Idade: ${_peopleViewModel.age}"),
                  ),
                );
              }),
          // child: Center(
          //   child: _busy
          //       ? Container(
          //           width: constraints.maxWidth * .5,
          //           child: FittedBox(
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceAround,
          //               children: [
          //                 Text(
          //                   "Carregando...  ",
          //                   style: TextStyle(
          //                     color: Colors.blue[900],
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 20,
          //                   ),
          //                 ),
          //                 Container(
          //                   width: 20,
          //                   height: 20,
          //                   child: CircularProgressIndicator(
          //                     color: Colors.blue[900],
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         )
          //       : Text("${constraints.maxHeight}\n${constraints.maxWidth}"),
          // ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Novo",
        backgroundColor: Colors.blue[900],
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.createEditRoute,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
