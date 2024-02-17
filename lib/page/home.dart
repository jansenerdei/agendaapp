import 'package:agendaapp/model/agenda_model.dart';
import 'package:agendaapp/page/contato_page.dart';
import 'package:agendaapp/repository/agenda_repository.dart';
import 'package:agendaapp/services/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AgendaRepository agendaRepository = AgendaRepository();
  var _agenda = AgendaModel([]);
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
    _agenda = await agendaRepository.obterAgenda();
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
        ),
        drawer: const CustomDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              carregando
                  ? const CircularProgressIndicator()
                  : Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ContatoPage()));
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: ShapeDecoration(
                            shape: Border.all(
                              color: Colors.black38,
                              style: BorderStyle.solid,
                            ),
                            color: Colors.amberAccent[200],
                          ),
                          child: const Text(
                            "Novo Contato",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _agenda.results.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var contato = _agenda.results[index];
                      return Card(
                        elevation: 10,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: const ShapeDecoration(
                                  shape: CircleBorder(), color: Colors.white),
                              child: const FaIcon(FontAwesomeIcons.person),
                            ),
                            Text(contato.nome.toString(),
                                style: const TextStyle(fontSize: 18)),
                            Text(contato.phone.toString(),
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ); //>>> CRIAR A LISTA DE CONTATOS <<<
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
