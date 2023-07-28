

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kara_workshop/model/favor.dart';

class FavorStateNotifier extends StateNotifier<List<FavorModel>>{
  FavorStateNotifier() : super([]);

  void addFavor(FavorModel favor){
    state = [...state, favor];
  }

  void changeFavorState(String id, FavorState favorState){
    state = [
      for(final favor in state)
       if(favor.id == id)
          favor.copyWith(favorState: favorState)
        else
          favor,
      
    ];
  }


}

final favorProvider = StateNotifierProvider<FavorStateNotifier, List<FavorModel>>((ref) => FavorStateNotifier());