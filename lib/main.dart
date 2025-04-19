import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voting App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: CandidateProfile(),
    );
  }
}

class CandidateProfile extends StatelessWidget {
  CandidateProfile({super.key});

  // Constants
  final uiBox = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 4,
          spreadRadius: 0.2,
          offset: const Offset(0, 2),
        ),
      ]
  );
  final textColor = const Color(0xFF1a1a1a);
  final secondaryColor = const Color(0xFF194197);
  final buttonFocused = const Color(0xFF194197);
  final buttonTextFocused = const Color(0xFFFFFFFF);
  final buttonUnfocused = const Color(0xFF194197).withValues(alpha: .25);
  final buttonTextUnfocused = const Color(0xFF194197);
  



  // Candidate Information
  final candidatePos = 'BSCS Representatives';
  final candidateName = 'Daniel Catedrilla';
  final candidateProg = 'BS Computer Science';
  final candidateYear = '2nd Year';
  final candidateDescription = 'Daniel Catedrilla is a 2nd year BS Computer Science student at the Iloilo Science and Technology University. He is a member of the ISAT-U Computer Science Society and has been involved in various projects and activities within the organization. Daniel is passionate about technology and is committed to making a positive impact in his community through his work.';
  final candidateImage = '';
  final candidateAchievements = [
    'Dean\'s Lister',
    'Top 10 in Programming Contest',
    'Member of the ISAT-U Computer Science Society',
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            children: [
              Image(
                image: AssetImage(candidateImage.isNotEmpty ? candidateImage : 'placeholder.png'),
                fit: BoxFit.fitWidth,
                ),
              Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16.0,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                            candidateName.toUpperCase(),
                            style: GoogleFonts.lexend(
                             fontSize: 28,
                             fontWeight: FontWeight.bold,
                             color: textColor,
                             height: 0.9
                            )
                          ),
                        Text(
                          '$candidateProg, $candidateYear',
                          style: GoogleFonts.lexend(
                           fontSize: 12,
                           fontWeight: FontWeight.bold,
                           color: secondaryColor, 
                          )
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end, 
                        children: [
                          TextButton(
                            onPressed: () {}, 
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: buttonFocused,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                'DETAILS',
                                style: GoogleFonts.lexend(
                                  color: buttonTextFocused,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            )
                          ),
                          TextButton(
                            onPressed: () {}, 
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: buttonUnfocused,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                'GOALS & PLATFORMS',
                                style: GoogleFonts.lexend(
                                  color: buttonTextUnfocused,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            )
                          ),
                        ],
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: uiBox,
                          child: Column(
                            spacing: 4.0,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DETAILS',
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9C9C9C), 
                                )
                              ),
                              Text(
                                candidateDescription,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.roboto(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                  color: textColor,
                                )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: uiBox,
                          child: Column(
                            spacing: 4.0,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ACHIEVEMENTS',
                                style: GoogleFonts.lexend(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9C9C9C), 
                                )
                              ),
                              Text(
                                candidateAchievements.join('\n'),
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.roboto(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                  color: textColor,
                                )
                              ),
                            ],
                          ),
                        ),
                  ],
                )
              ),
            ],
          ),
        );
  }
}


