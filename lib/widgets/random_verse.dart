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
            return Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('images/1.jpg'), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('images/black_layer.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).todaySlok,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrangeAccent),
                        ),
                        const Spacer(),
                        Text(
                          '${verse.slok}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return VersePage(
                                  chapterId: verse.chapter ?? 1,
                                  verseId: verse.verse ?? 1);
                            }));
                          },
                          child: Text(S.of(context).readMore,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
