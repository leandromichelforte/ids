import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ids/models/constants_model.dart';
import 'package:ids/repositories/account_repository.dart';
import 'package:ids/view-models/people_viewmodel.dart';
import 'package:ids/views/create_edit_view.dart';

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

  // MODAL INFERIOR EDITAR/EXCLUIR
  void _showBottomModal(PeopleViewModel peopleViewModelArg) {
    showModalBottomSheet(
        context: context,
        builder: (modalContext) {
          return Container(
            height: 100,
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () =>
                      //  print(peopleViewModel.toJson()),
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CreateEditView(peopleArg: peopleViewModelArg),
                    ),
                    // arguments: peopleViewModel.toJson(),
                  ),
                  icon: Icon(
                    Icons.edit,
                    size: 30,
                    color: Colors.blue[900],
                  ),
                ),
                IconButton(
                  onPressed: () => _showDeleteDialog(peopleViewModelArg),
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
  }

  // DIÁLOGO CONFIRMAÇÃO EXCLUSÃO
  void _showDeleteDialog(PeopleViewModel? peopleViewModel) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(
              "Deseja realmente excluir?",
              style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.w900,
              ),
            ),
            content: Text(
              "Ação não poderá ser desfeita.",
              style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(
                  "Não",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _repository
                    .deletePeople(peopleViewModel!)
                    .then((rowsAffected) async {
                  Fluttertoast.showToast(
                      msg: rowsAffected != 0
                          ? "${peopleViewModel.name ?? 'Fulano'} excluído com sucesso"
                          : "Erro ao excluir");
                  _loadPeoples();
                  Navigator.pop(context);
                  Navigator.pop(context);
                }),
                child: Text(
                  "Sim",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        });
  }

  // CARREGAR PESSOAS
  void _loadPeoples() {
    setState(() {
      _busy = true;
    });
    Future.delayed(
        Duration(seconds: 1),
        () async =>
            await _repository.getAllPeoples().then((listAllPeoples) async {
              allPeoples = listAllPeoples;
              setState(() {
                _busy = false;
              });
            }));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _loadPeoples());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Pessoas"),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          color: Colors.grey[300],
          child: _busy
              ? Center(
                  child: Container(
                    width: constraints.maxWidth * .5,
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Carregando...  ",
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.blue[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : allPeoples.isEmpty
                  ? Center(
                      child: Container(
                        width: constraints.maxWidth * .4,
                        child: FittedBox(
                          child: Text(
                            "Lista vazia :(",
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (_, index) => Divider(),
                      itemCount: allPeoples.length,
                      itemBuilder: (_, index) {
                        _peopleViewModel =
                            PeopleViewModel(peopleModel: allPeoples[index]);
                        return ListTile(
                          onTap: () => _showBottomModal(
                            new PeopleViewModel(
                              peopleModel: allPeoples[index],
                            ),
                          ),
                          title: Text(
                            _peopleViewModel.name ?? "Fulano",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              "Idade: ${_peopleViewModel.age}\n${_peopleViewModel.id}"),
                        );
                      }),
        );
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Novo",
        backgroundColor: Colors.blue[900],
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.createEditRoute,
          arguments: <String, Object?>{},
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
