import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kara_workshop/provider/favor_provider.dart';

class WaitingScreen extends ConsumerStatefulWidget {
  const WaitingScreen({super.key});

  @override
  ConsumerState<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends ConsumerState<WaitingScreen> {

  @override
  Widget build(BuildContext context) {
    var favorSync = ref.watch(favorProvider);
     return favorSync.when(
    loading: () => const CircularProgressIndicator(),
    error: (err, stack) => Text('Error: $err'),
    data: (favor) {
      return  listView(favor);
    },
  );
  }

  ListView listView(favors) {
    return ListView.builder(
    itemBuilder: (context, index) => FavorCard(
        motif: favors[index]["motif"],
        description: favors[index]["description"]),
      itemCount: favors.length,
  );
  }
}

class FavorCard extends StatelessWidget {
  final String motif;
  final String description;
  const FavorCard({
    super.key,
    required this.motif,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text("O"),
            ),
            title: Text(motif),
            subtitle: Text(description),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.check),
                style: IconButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
                style: IconButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              )
            ],
          )
        ],
      ),
    );
  }
}
