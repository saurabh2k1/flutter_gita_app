import 'package:flutter/material.dart';
import 'package:flutter_gita_app/generated/l10n.dart';
import 'package:flutter_gita_app/pages/verse_page.dart';
import 'package:flutter_gita_app/services/local_json.dart';

class RandomVerse extends StatelessWidget {
  RandomVerse({super.key});
  final LocalJsonService localJsonService = LocalJsonService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: localJsonService.getRandomVerse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load verse'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No verse found'));
          } else {
            final verse = snapshot.data!;
            return Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('images/1.jpg'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                //Black overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('images/black_layer.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Today's Slok
                        Text(
                          S.of(context).todaySlok,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        // Verse text
                        Text(
                          '${verse.slok}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        // Read more Button
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VersePage(
                                    chapterId: verse.chapter ?? 1,
                                    verseId: verse.verse ?? 1,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).readMore,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}
