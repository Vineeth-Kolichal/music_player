import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PageAllSongs extends StatelessWidget {
  final OnAudioQuery audioQuery;
  const PageAllSongs({super.key, required this.audioQuery});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            if (item.hasError) {
              return Center(child: Text(item.error.toString()));
            }

            // Waiting content.
            if (item.data == null) {
              return Center(child: const CircularProgressIndicator());
            }

            // 'Library' is empty.
            if (item.data!.isEmpty) return const Text("Nothing found!");
            return ListView.separated(
              itemCount: item.data!.length,
              itemBuilder: (ctx, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.4, color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 202, 248, 203),
                      Color.fromARGB(255, 184, 219, 247)
                    ]),
                  ),
                  child: ListTile(
                    onTap: () {
                      print('open mini');
                    },
                    leading: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 3,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: QueryArtworkWidget(
                            artworkClipBehavior: Clip.none,
                            nullArtworkWidget: Image.asset(
                              'assets/images/default_music_thumbnail.jpg',
                              fit: BoxFit.cover,
                            ),
                            controller: audioQuery,
                            id: item.data![index].id,
                            type: ArtworkType.AUDIO,
                          ),
                        ),
                      ),
                    ),
                    title: SizedBox(
                      height: 20,
                      child: Marquee(
                        text: item.data![index].title,
                        style: TextStyle(),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20,
                        velocity: 25,
                        pauseAfterRound: Duration(seconds: 1),
                        startPadding: 0,
                        accelerationDuration: Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                      ),
                    ),
                    subtitle: Text(
                      item.data![index].artist ?? "<Unknown>",
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                        onPressed: () {}, icon: Icon(Icons.more_vert)),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 7,
                );
              },
            );
          }),
    );
  }
}
