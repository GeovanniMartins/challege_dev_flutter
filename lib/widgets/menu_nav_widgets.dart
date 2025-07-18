import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//build the menu "Ajuda"
class MenuNavWidgetHelp extends StatelessWidget {
  const MenuNavWidgetHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.link),
          title: Text('Chamados'),
          onTap: () async {
            const url = 'https://cesla.ind.br';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            }
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('SAC: 0800 123 456'),
          onTap: () async {
            const phone = 'tel:0800123456';
            if (await canLaunchUrl(Uri.parse(phone))) {
              await launchUrl(phone as Uri);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

//build the menu "Menu"
class MenuNavWidgetMenu extends StatelessWidget {
  const MenuNavWidgetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ExpansionTile(
            leading: Icon(Icons.book),
            title: Text('Cursos'),
            children: [
              ListTile(
                title: Text('Graduação'),
                onTap: () async {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Pos-graduação'),
                onTap: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.school),
            title: Text('Acadêmico'),
            children: [
              ListTile(
                title: Text('Perfil'),
                onTap: () async {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Notas'),
                onTap: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () async {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

//build the menu "Notificações"
class MenuNavWidgetNotification extends StatelessWidget {
  const MenuNavWidgetNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Notificações',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificação 1'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificação 2'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
