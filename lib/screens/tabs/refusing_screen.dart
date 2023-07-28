import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kara_workshop/favorState.dart';
import 'package:kara_workshop/model/favor.dart';

class RefusingScreen extends ConsumerStatefulWidget {
  const RefusingScreen({super.key});

  @override
  ConsumerState<RefusingScreen> createState() => _RefusingScreenState();
}

class _RefusingScreenState extends ConsumerState<RefusingScreen> {
  @override
   Widget build(BuildContext context) {
    final acceptedFavor = ref.watch(favorProvider).where((element) => element.favorState == FavorState.rejected).toList();
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
