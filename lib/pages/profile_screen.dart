import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_db/constants/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Text statTitleStyle(BuildContext context, String text) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      );
    }

    Text statDescStyle(BuildContext context, String text) {
      return Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 70, right: 20, bottom: 50),
              width: double.infinity,
              child: Card(
                elevation: 8.0,
                color: Constants.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 60),
                    const Text(
                      'Wantrisnadi Gusti',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Wacik',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            statTitleStyle(context, '0'),
                            const SizedBox(height: 5),
                            statDescStyle(context, 'Watched'),
                            statDescStyle(context, 'Movies')
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const SizedBox(height: 20),
                            RatingBarIndicator(
                              rating: 0.7,
                              itemCount: 1,
                              itemSize: 50,
                              unratedColor: Colors.white,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 219, 205, 77),
                            )),
                            const SizedBox(height: 5),
                            const Text(
                              '7.33',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 219, 205, 77),
                              ),
                            ),
                            const SizedBox(height: 5),
                            statDescStyle(context, 'Average Rating'),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            statTitleStyle(context, '0'),
                            const SizedBox(height: 5),
                            statDescStyle(context, 'Watched'),
                            statDescStyle(context, 'TV Show')
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white, 
                            width: 2.0, 
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () => launchBrowser(Constants.githubURL),
                            child: Container(
                              width: 35.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all( Radius.circular(17.0)),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: SvgPicture.asset(
                                  'assets/icons/github-icon.svg',
                                  semanticsLabel: 'Github Icon',
                                  width: 30,
                                  height: 30,
                                )
                              ), 
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () => launchBrowser(Constants.linkedinURL),
                            child: Container(
                              width: 35.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all( Radius.circular(17.0)),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: SvgPicture.asset(
                                  'assets/icons/linkedin-icon.svg',
                                  semanticsLabel: 'Linkedin Icon',
                                  width: 30,
                                  height: 30,
                                )
                              ), 
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () => launchEmail(Constants.email),
                            child: Container(
                              width: 35.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all( Radius.circular(17.0)),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: SvgPicture.asset(
                                  'assets/icons/gmail-icon.svg',
                                  semanticsLabel: 'Gmail Icon',
                                  color: Colors.white,
                                  width: 30,
                                  height: 30,
                                )
                              ), 
                            ),
                          ),   
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              child: Stack(
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic launchBrowser(String url) async {
    try
    {
      Uri email = Uri(
        scheme: 'https',
        path: url
      );

      await launchUrl(email);
    }
    catch(e) {
      debugPrint(e.toString());
    }
  }

  dynamic launchEmail(String email) async {
    try
    {
      Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
          'subject': "Haloooo"
        },
      );

      await launchUrl(emailUri);
    }
    catch(e) {
      debugPrint(e.toString());
    }
  }
}

