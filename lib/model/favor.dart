import 'package:flutter/widgets.dart';

enum FavorState { pending, accepted, rejected }

@immutable
class FavorModel {
  final String id;
  final String motif;
  final String description;
  final String friendName;

  final DateTime dateTime;
  final FavorState favorState;

  const FavorModel(
      {
        required this.id,
        required this.friendName,

        required this.motif,
      required this.description,
      required this.dateTime,
      required this.favorState});

  FavorModel copyWith(
      {String? motif,
      String? description,
      String? friendName,

      DateTime? dateTime,
      FavorState? favorState}) {
    return FavorModel(
        id : this.id,
        friendName: friendName ?? this.friendName,

        motif: motif ?? this.motif,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
        favorState: favorState ?? this.favorState);
  }
}
