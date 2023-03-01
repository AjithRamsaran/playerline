import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/player_data_response.dart';

class ListItemWidget extends StatelessWidget {
  final Player player;

  const ListItemWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        child: player.playerImageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: player.playerImageUrl ?? "",
                                memCacheWidth: 200,
                                memCacheHeight: 200,
                              )
                            : Image.asset('assets/ic_launcher.png'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 6),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFF3c3c3c), width: 1.0)),
                        //color: Color.fromRGBO(230, 230, 230, 0.1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: player.pname ?? "",
                                        style: const TextStyle(
                                            color: Color(0xFFe89832),
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                        children: [
                                          TextSpan(
                                            text: " ${player.position}",
                                            style: const TextStyle(
                                                color: Color(0xFF767676),
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                              const Text(
                                "Wednesday",
                                style: TextStyle(
                                    color: Color(0xFF8c8c8c),
                                    fontSize: 14,
                                    // fontFamily: 'poppins',
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      player.title ?? "",
                                      softWrap: true,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          //Color(0xFFe89832),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: player.sourceLogo != null
                                            ? CachedNetworkImage(
                                                imageUrl:
                                                    player.sourceLogo ?? "",
                                                memCacheWidth: 40,
                                                memCacheHeight: 40,
                                              )
                                            : Image.asset(
                                                'assets/ic_launcher.png'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              (player.details ?? "").replaceAll("\n", " "),
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Color(0xFF848484),
                                  //Color(0xFFe89832),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
