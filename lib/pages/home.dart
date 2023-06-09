import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//models
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 10),
    Band(id: '3', name: 'Twenty One Pillots', votes: 2),
    Band(id: '4', name: 'The 1975', votes: 4),
    Band(id: '5', name: 'Guns and Roses', votes: 1)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title:
            const Text("Band Names", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => bandTile(bands[i])),
    );
  }

  Widget bandTile(Band band) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        //TODO: LLamar el borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Delete band",
              style: TextStyle(color: Colors.white),
            )),
      ),
      key: Key(band.id),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(band.name.substring(0, 2))),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
        title: Text(band.name),
      ),
    );
  }

  addNewBand() {
    final textCtrl = TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("New band name:"),
              content: TextField(controller: textCtrl),
              actions: [
                MaterialButton(
                    elevation: 1,
                    textColor: Colors.blue,
                    child: const Text("Enter"),
                    onPressed: () {
                      addBandToList(textCtrl.text);
                    })
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: const Text("New band name"),
              content: CupertinoTextField(
                controller: textCtrl,
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("Add"),
                  onPressed: () {
                    addBandToList(textCtrl.text);
                  },
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text("Dismiss"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  void addBandToList(String bandName) {
    if (bandName.isNotEmpty) {
      bands.add(Band(id: DateTime.now().toString(), name: bandName, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
