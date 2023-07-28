import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kara_workshop/favorState.dart';
import 'package:kara_workshop/model/favor.dart';
import 'package:uuid/uuid.dart';

class AddFavorScreen extends ConsumerStatefulWidget {
  const AddFavorScreen({super.key});

  @override
  ConsumerState<AddFavorScreen> createState() => _AddFavorScreenState();
}

class _AddFavorScreenState extends ConsumerState<AddFavorScreen> {
  List<String> names = ["Jérémie", "Aïcha", "Thierry", "Esther"];
  final dateController = TextEditingController();
  final motifController = TextEditingController();
  final desciptionController = TextEditingController();
  late DateTime datetime;
  String? friendName;
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            FavorModel model = FavorModel(id: Uuid().v4(), friendName: friendName!, motif: motifController.text,
             description: desciptionController.text, dateTime: datetime, favorState: FavorState.pending);
             ref.read(favorProvider.notifier).addFavor(model);
             Navigator.pop(context);
          },
          child: const Row(
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
                 friendName = value;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Choisir un ami"),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: motifController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Taper le motif"),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: desciptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Taper la description"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: dateController,
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2070));
                    if (date != null){
                      datetime = date;
                      dateController.text = date.toString().split(" ")[0];
                    }
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
