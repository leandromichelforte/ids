import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ids/models/constants_model.dart';
import 'package:ids/models/people_model.dart';
import 'package:ids/repositories/account_repository.dart';
import 'package:intl/intl.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';

class CreateEditView extends StatefulWidget {
  CreateEditView({Key? key}) : super(key: key);

  @override
  _CreateEditViewState createState() => _CreateEditViewState();
}

class _CreateEditViewState extends State<CreateEditView> {
  final _formKey = GlobalKey<FormState>();
  String appBarTitle = "Novo";
  PeopleModel _people = PeopleModel();
  List<String> _genders = ["Masculino", "Feminino", "Indiferente"];
  String dropDownValue = "Masculino";
  TextEditingController _birthDateController = TextEditingController();
  MaskInputFormatter dateMask = MaskInputFormatter(mask: '##/##/####');
  DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
  AccountRepository _repository = AccountRepository();

  // DIÁLOGO CANCELAR/VOLTAR
  Future<bool> _showCancelDialog() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(
              "Deseja realmente sair?",
              style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.w700,
              ),
            ),
            content: Text(
              "Todas as informações não salvas serão perdidas.",
              style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.w700,
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
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, Routes.homeRoute, (route) => false),
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
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    _repository.db;
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(appBarTitle),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => _showCancelDialog(),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              print(await _repository.getId());
              _people.printy();
            },
            icon: Icon(Icons.ac_unit),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: _showCancelDialog,
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(5),
                child: SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        maxLength: 70,
                        onSaved: (value) async {
                          _people.id = await _repository.getId();
                          _people.name = value;
                        },
                        validator: (value) {
                          if (value != null) if (value.isEmpty)
                            return "Não pode ficar vazio";
                          return null;
                        },
                        onEditingComplete: () => node.nextFocus(),
                        cursorColor: Colors.blue[900],
                        decoration: InputDecoration(
                          hintText: "Nome completo",
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        inputFormatters: [dateMask],
                        controller: _birthDateController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _people.birthDate =
                              dateFormatter.parse(value!.replaceAll("/", "-"));
                        },
                        onChanged: (value) {},
                        validator: (value) {
                          if ([null, ""].contains(value)) {
                            return "Não pode ficar vazio";
                          } else if (value?.length != 10) {
                            return "Insira uma data válida";
                          }
                        },
                        onEditingComplete: () => node.nextFocus(),
                        cursorColor: Colors.blue[900],
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((value) {
                                _birthDateController.text =
                                    DateFormat('dd/MM/yyyy')
                                        .format(value!)
                                        .toString();
                                print(DateFormat('dd/MM/yyyy').format(value));
                              });
                            },
                            icon: Icon(
                              Icons.calendar_today_rounded,
                              size: 20,
                            ),
                          ),
                          hintText: "Data de nascimento",
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      DropdownButtonFormField(
                        onSaved: (String? value) {
                          _people.gender = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_downward_rounded,
                          size: 20,
                        ),
                        value: dropDownValue,
                        items: _genders
                            .map(
                              (e) => DropdownMenuItem<String>(
                                child: Row(
                                  children: [
                                    Text(e),
                                  ],
                                ),
                                value: e,
                              ),
                            )
                            .toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[900]),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            onPressed: () => _showCancelDialog(),
                            child: Text("Cancelar"),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[900]),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                _repository
                                    .newPeople(_people)
                                    .then((rowsAffected) {
                                  if (rowsAffected == _people.id) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "${_people.name} salvo com sucesso");
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        Routes.homeRoute, (route) => false);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Erro ao salvar");
                                  }
                                });
                              }
                            },
                            child: Text("Salvar"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
