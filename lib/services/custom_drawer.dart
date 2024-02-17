import 'package:agendaapp/page/contato_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // >>>> INICIO DO DRAWER <<<<
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 5),
                  Text("Cadastro"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ContatoPage()));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
