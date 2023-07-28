import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kara_workshop/favorState.dart';
import 'package:kara_workshop/model/favor.dart';

class WaitingScreen extends ConsumerStatefulWidget {
  const WaitingScreen({super.key});

  @override
  ConsumerState<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends ConsumerState<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    final pendingFavor = ref.watch(favorProvider).where((element) => element.favorState == FavorState.pending).toList();

    return ListView.builder(
      itemCount: pendingFavor.length,
      itemBuilder: (context, index) {
      return Card(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Text(pendingFavor[index].friendName[0]),
                ),
                title: Text(pendingFavor[index].motif),
                subtitle:
                    Text(pendingFavor[index].description),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      ref.read(favorProvider.notifier).changeFavorState(pendingFavor[index].id, FavorState.accepted);
                    },
                    icon: Icon(Icons.check),
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.green.shade500,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(favorProvider.notifier).changeFavorState(pendingFavor[index].id, FavorState.rejected);

                    },
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
    },);
  }
}
