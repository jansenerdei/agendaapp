import 'package:agendaapp/model/agenda_old_model.dart';
import 'package:agendaapp/page/contato_page.dart';
import 'package:agendaapp/repository/agenda_repository.dart';
import 'package:agendaapp/services/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AgendaRepository agendaRepository = AgendaRepository();
  final _agenda = AgendaModel([]);
  // var contato = ContatoModel();
  var nomeController = TextEditingController();
  var telefoneController = TextEditingController();
  var thumbController = TextEditingController();
  bool carregando = false;

  @override
  void initState() {
    super.initState();
    obterDados();
  }

  void obterDados() async {
    setState(() {
      carregando = true;
    });
    // _agenda = await agendaRepository.obterAgenda();
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text("Agenda de Contatos"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.plus),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContatoPage()));
              },
            )
          ],
        ),
        drawer: const CustomDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              carregando
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                          itemCount: _agenda.agenda.length,
                          itemBuilder: (BuildContext bc, int index) {
                            var contato = _agenda.agenda[index];
                            return Text(contato.nome
                                .toString()); //>>> CRIAR A LISTA DE CONTATOS <<<
                          }),
                    )
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // nomeController = "";
        //     // telefoneController = "";
        //     // thumbController = "";
        //     showDialog(
        //         context: context,
        //         builder: (BuildContext bc) {
        //           return AlertDialog(
        //             title: const Text("Novo Contato"),
        //             content: Column(
        //               children: [
        //                 TextField(
        //                   controller: nomeController,
        //                 ),
        //                 TextField(
        //                   controller: telefoneController,
        //                 ),
        //               ],
        //             ),
        //           );
        //         });
        //   },
        //   tooltip: 'Novo Contato',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
