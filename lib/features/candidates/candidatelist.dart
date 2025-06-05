import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../sample_data/candidate.dart'; 
import 'candidateprofile.dart';
import '../../components/constants.dart';

class CandidateList extends StatefulWidget {

  const CandidateList({super.key});

  @override
  State<CandidateList> createState() => _CandidateListState();
}

class _CandidateListState extends State<CandidateList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Text(
                'Candidates',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Constants.primaryColor,
                ),
              ),
            ),
            ...List.generate(candidates.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CandidateProfile(
                        onBackState: (index) {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        candidate: candidates[index],
                      ),
                    ),
                  );
                },
                
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(candidates[index].imagePath),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            candidates[index].name,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Constants.primaryColor,
                            ),
                          ),
                          Text(
                            'Running for ${candidates[index].runningFor}',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Constants.primaryColor.withAlpha(85),
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
              );
            }),
          ],
          )
      ),
    );
  }
}