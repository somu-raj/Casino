

import 'package:flutter/material.dart';
import 'package:roullet_app/Helper_Constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class PlayerLoadingWidget extends StatelessWidget {
  const PlayerLoadingWidget({super.key, required this.player});
  final int player;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/dummy.png",
                    fit: BoxFit.fill,
                    scale: 2.1,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                  Text(
                  "Player $player",
                  style: const TextStyle(
                      color: colors.borderColorDark),
                ),
              ],
            ),
          ),
        ),
        buildShimmer(120,125)
      ],
    );
  }
}

class RoomUserWidget extends StatelessWidget {
  const RoomUserWidget({super.key, required this.userImage, required this.userName, required this.player, required this.roomJoined, });
  final String userImage;
  final String? userName;
  final int player;
  final bool roomJoined;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 120,
      width: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
        Border.all(color: colors.borderColorDark, width: 2),
      ),
      child: !roomJoined
          ?  PlayerLoadingWidget( player: player,)
          :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              userImage,
              fit: BoxFit.fill,
              scale: 3.1,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            userName??"Player $player",
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}



Widget buildShimmer(double height, double width, {double? radius}) {
  return SizedBox(
    height: height,
    width: width,
    child: Shimmer.fromColors(
      baseColor: Colors.transparent,
      highlightColor: Colors.grey[100]!.withOpacity(0.5),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10)),
        color: Colors.white,
      ),
    ),
  );
}

