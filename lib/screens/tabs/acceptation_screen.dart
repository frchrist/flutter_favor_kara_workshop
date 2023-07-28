import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kara_workshop/favorState.dart';
import 'package:kara_workshop/model/favor.dart';

class AcceptationScreen extends ConsumerStatefulWidget {
  const AcceptationScreen({super.key});

  @override
  ConsumerState<AcceptationScreen> createState() => _AcceptationScreenState();
}

class _AcceptationScreenState extends ConsumerState<AcceptationScreen> {
  @override
  Widget build(BuildContext context) {
    final acceptedFavor = ref.watch(favorProvider).where((element) => element.favorState == FavorState.accepted).toList();
    return ListView.builder(itemBuilder:  (context, index) => Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(acceptedFavor[index].friendName[0]),
            ),
            title: Text(acceptedFavor[index].motif),
            subtitle: Text(acceptedFavor[index].description),
          ),
        ) , itemCount: acceptedFavor.length);
  }
}
