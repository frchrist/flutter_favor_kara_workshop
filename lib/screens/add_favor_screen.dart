import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddFavorScreen extends StatefulWidget {
  const AddFavorScreen({super.key});

  @override
  State<AddFavorScreen> createState() => _AddFavorScreenState();
}

class _AddFavorScreenState extends State<AddFavorScreen> {
  List<String> names = ["Jérémie", "Aïcha", "Thierry", "Esther"];
  late String name;
  TextEditingController _motifController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  var appFavor = Hive.box("app_data");

  Future addFavor(
      String name, String motif, String description, String date) async {
    Map<String, String> favor = {
      "name": name,
      "motif": motif,
      "description": description,
      "date": date
    };
    List<dynamic> favorList = appFavor.get("favors", defaultValue: []);
    favorList.add(favor);

    appFavor.put("favors", favorList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ajouter une faveur",
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // validation Data
        child: ElevatedButton(
          onPressed: () {
            addFavor(name, _motifController.text, _descriptionController.text,
                    _dateController.text)
                .then((value) {
              ;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("VALIDER"), Icon(Icons.add)],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            DropdownButtonFormField(
              items: names
                  .map((name) => DropdownMenuItem(
                        child: Text(name),
                        value: name,
                      ))
                  .toList(),
              onChanged: (value) {
                name = value!;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Choisir un ami"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _motifController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Taper le motif"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 4,
              controller: _descriptionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Taper la description"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _dateController,
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050, 12, 31));
                _dateController.text = date.toString().split(" ")[0];
              },
              readOnly: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Choisir une date"),
            )
          ],
        ),
      ),
    );
  }
}
