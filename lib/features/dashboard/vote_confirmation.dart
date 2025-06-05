import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:eleksyon/components/constants.dart'; 

Future<bool?> showVoteConfirmationModal(
  BuildContext context, {
  required String candidateName,
  required String positionTitle,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // User must explicitly choose Yes or No
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //header title
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: Constants.primaryColor, // Use theme color
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Text(
              'Confirm Your Vote',
              style: GoogleFonts.inter( // Use GoogleFonts
                  color: Constants.secondaryColor, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'You are about to vote for:',
                  style: GoogleFonts.inter(color: Colors.black54, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  candidateName,
                  style: GoogleFonts.inter(
                    color: Constants.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'for the position of',
                  style: GoogleFonts.inter(color: Colors.black54, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  positionTitle,
                  style: GoogleFonts.inter(
                    color: Constants.primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  'Are you sure you want to cast this vote? This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: Colors.red.shade700, fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey.shade400)
                      )
                    ),
                    onPressed: () => Navigator.of(context).pop(false), // Return false
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(color: Colors.grey.shade700, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      foregroundColor: Constants.secondaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true); // Return true
                      // Actual confirmation logic will be handled in the dashboard
                    },
                    child: Text('Yes, Confirm Vote', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
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
