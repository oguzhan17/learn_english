import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

enum Level { Hard, Medium, Easy }

List<String> fillSourceArray() {
  return [
    'Cat',
    'Cat',
    'Köpek',
    'Dog',
    'Arı',
    'Bee',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/04/donkey-tiny-png-300x242.png',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/04/donkey-tiny-png-300x242.png',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/04/eagle-.jpg',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/04/eagle-.jpg',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/04/shutterstock_1702769653-removebg-preview.png',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/04/shutterstock_1702769653-removebg-preview.png',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/11/20182F012F252F142F412F082F9b1e2c83-d95f-446a-915d-a3a0e0009ef12FPigClean.png',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/11/20182F012F252F142F412F082F9b1e2c83-d95f-446a-915d-a3a0e0009ef12FPigClean.png',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/04/shutterstock_519474715-removebg-preview-1.png',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/04/shutterstock_519474715-removebg-preview-1.png',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/11/20172F092F142F082F182F322Ff55e2d0b-a453-41e5-a40e-1df1e13870e62FTurtle-Animalsname.png',
    'https://wp-cdn.lingokids.com/wp-content/uploads/2020/11/20172F092F142F082F182F322Ff55e2d0b-a453-41e5-a40e-1df1e13870e62FTurtle-Animalsname.png',
  ];
}

List getSourceArray(
    Level level,
    ) {
  List<String> levelAndKindList = new List<String>();
  List sourceArray = fillSourceArray();
  if (level == Level.Hard) {
    sourceArray.forEach((element) {
      levelAndKindList.add(element);
    });
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  }

  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> getInitialItemState(Level level) {
  List<bool> initialItemState = new List<bool>();
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      initialItemState.add(true);
    }
  }
  return initialItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level) {
  List<GlobalKey<FlipCardState>> cardStateKeys =
  new List<GlobalKey<FlipCardState>>();
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  return cardStateKeys;
}