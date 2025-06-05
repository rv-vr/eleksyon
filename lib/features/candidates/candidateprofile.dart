import 'package:flutter/material.dart';
import '../../components/constants.dart';
import '../sample_data/candidate.dart';
import 'package:google_fonts/google_fonts.dart';

class CandidateProfile extends StatelessWidget {
  final Function(int) onBackState;  // Callback function to update state
  final Candidate candidate; // Candidate object

  const CandidateProfile({super.key, required this.onBackState, required this.candidate});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Image(
                    image: AssetImage(candidate.imagePath),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        onBackState(0);
                      }, 
                      icon: Icon(
                        Icons.arrow_back,
                        color: Constants.secondaryColor,
                        size: 24,
                      )
                      )
                  ),
                ]
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ), 
                  color: Constants.primaryColor
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Constants.secondaryColor,
                      ),
                    ),
                    Text(
                      '${candidate.year}, ${candidate.program}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              DetailsSection(candidate: candidate), 
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsSection extends StatefulWidget {
  final Candidate candidate; 

  const DetailsSection({super.key, required this.candidate});

  @override
  State<DetailsSection> createState() => _DetailsSectionState();
}

class _DetailsSectionState extends State<DetailsSection> {

  var currentTab = 0; 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  minimumSize: WidgetStateProperty.all<Size>(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: currentTab == 0 ? Constants.primaryColor : Constants.primaryColor.withAlpha(45),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Details',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: currentTab == 0 ? Constants.secondaryColor : Colors.black,
                    ),
                  ),
                )
                ),
              const SizedBox(width: 8.0),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  minimumSize: WidgetStateProperty.all<Size>(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: currentTab == 1 ? Constants.primaryColor : Constants.primaryColor.withAlpha(45),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Platforms',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: currentTab == 1 ? Constants.secondaryColor : Colors.black,
                    ),
                  ),
                )
                ),
            ],
          ),
          Text(
            widget.candidate.description,
          ),
          
          
          if (currentTab == 0) ...[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Constants.primaryColor.withAlpha(45),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACHIEVEMENTS',
                    style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    List.generate(
                      widget.candidate.achievements.length, 
                      (index) {
                        return widget.candidate.achievements[index];
                      }
                    ).join('\n'),
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                  ),
                ],
            )
          ),
          ] else ...[
            Text(
              'PLATFORMS',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.black
              ),
            ),
            ...List.generate(
              widget.candidate.platforms.length, 
              (index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withAlpha(45),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.candidate.platforms[index].title,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.candidate.platforms[index].description,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                      ),
                    ],
                  )
                );
              }
            )
          ],

        ],
      ),
    );
  }
}