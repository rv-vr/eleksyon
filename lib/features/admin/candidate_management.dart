import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eleksyon/components/constants.dart';
import '../models/admin_candidate_model.dart';

class CandidateManagementPage extends StatefulWidget {
  const CandidateManagementPage({super.key});

  @override
  State<CandidateManagementPage> createState() => _CandidateManagementPageState();
}

class _CandidateManagementPageState extends State<CandidateManagementPage> {
  final List<AdminCandidate> _candidates = [
    AdminCandidate(id: 'dc001', name: 'Daniel Catedrilla', course: 'BS Computer Science', year: '2nd Year', runningFor: 'Governor', party: 'TDA', imagePath: 'candidates/DC001.jpg'),
    AdminCandidate(id: 'mm002', name: 'Matthew Mallorca', course: 'BS Computer Science', year: '2nd Year', runningFor: 'Vice Governor', party: 'CompuTeam', imagePath: 'candidates/MM002.jpg'),
  ];

  void _showCandidateForm({AdminCandidate? candidate}) {
    final _formKey = GlobalKey<FormState>();
    String name = candidate?.name ?? '';
    String course = candidate?.course ?? '';
    String year = candidate?.year ?? '';
    String runningFor = candidate?.runningFor ?? '';
    String party = candidate?.party ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(candidate == null ? 'Add New Candidate' : 'Edit Candidate', style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: Constants.primaryColor)),
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Placeholder for Image Picker
                  // Center(
                  //   child: Stack(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 40,
                  //         backgroundColor: Colors.grey.shade200,
                  //         // backgroundImage: selectedImageBytes != null ? MemoryImage(selectedImageBytes) : (candidate?.imagePath != null ? AssetImage(candidate!.imagePath!) : null),
                  //         // child: selectedImageBytes == null && candidate?.imagePath == null ? Icon(Icons.person, size: 40, color: Colors.grey) : null,
                  //       ),
                  //       Positioned(
                  //         bottom: 0, right: 0,
                  //         child: InkWell(
                  //           onTap: () async { /* Implement image picking */ },
                  //           child: CircleAvatar(radius: 15, backgroundColor: Constants.primaryColor, child: Icon(Icons.edit, size: 15, color: Constants.secondaryColor)),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 16),
                  _buildTextFormField(initialValue: name, label: 'Full Name', onSaved: (val) => name = val!),
                  _buildTextFormField(initialValue: course, label: 'Course/Program', onSaved: (val) => course = val!),
                  _buildTextFormField(initialValue: year, label: 'Year Level', onSaved: (val) => year = val!),
                  _buildTextFormField(initialValue: runningFor, label: 'Running For (Position)', onSaved: (val) => runningFor = val!),
                  _buildTextFormField(initialValue: party, label: 'Partylist', onSaved: (val) => party = val!),
                ],
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: GoogleFonts.inter(color: Colors.grey.shade700)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton.icon(
              icon: Icon(candidate == null ? Icons.add : Icons.save, color: Constants.secondaryColor),
              label: Text(candidate == null ? 'Add' : 'Save Changes', style: GoogleFonts.inter(color: Constants.secondaryColor, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(backgroundColor: Constants.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {
                    if (candidate == null) {
                      _candidates.add(AdminCandidate(
                        id: DateTime.now().millisecondsSinceEpoch.toString(), // Simple unique ID
                        name: name, course: course, year: year, runningFor: runningFor, party: party,
                        imagePath: 'candidates/placeholder.png' // Default or use picked image
                        // imageBytes: selectedImageBytes,
                      ));
                    } else {
                      candidate.name = name; candidate.course = course; candidate.year = year;
                      candidate.runningFor = runningFor; candidate.party = party;
                      // candidate.imageBytes = selectedImageBytes ?? candidate.imageBytes; // Update image if new one picked
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextFormField({required String initialValue, required String label, required Function(String?) onSaved}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(color: Constants.primaryColor.withOpacity(0.8)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Constants.primaryColor, width: 1.5), borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        style: GoogleFonts.inter(),
        validator: (value) => value == null || value.isEmpty ? 'Please enter $label' : null,
        onSaved: onSaved,
      ),
    );
  }

  void _deleteCandidate(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirm Deletion', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to delete this candidate?', style: GoogleFonts.inter()),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Cancel', style: GoogleFonts.inter())),
          TextButton(
            onPressed: () {
              setState(() {
                _candidates.removeWhere((c) => c.id == id);
              });
              Navigator.of(ctx).pop();
            },
            child: Text('Delete', style: GoogleFonts.inter(color: Colors.red.shade700, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidate Management', style: GoogleFonts.inter(fontWeight: FontWeight.w900, color: Constants.secondaryColor)),
        backgroundColor: Constants.primaryColor,
        elevation: 1.0,
      ),
      body: _candidates.isEmpty
          ? Center(child: Text('No candidates added yet. Tap + to add.', style: GoogleFonts.inter(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _candidates.length,
              itemBuilder: (context, index) {
                final candidate = _candidates[index];
                return Card(
                  elevation: 1.5,
                  margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: candidate.imagePath != null ? AssetImage(candidate.imagePath!) : null,
                      backgroundColor: Colors.grey.shade200,
                      child: candidate.imagePath == null ? const Icon(Icons.person_outline, color: Colors.grey) : null,
                    ),
                    title: Text(candidate.name, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${candidate.course} - ${candidate.year}', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700])),
                        Text('For: ${candidate.runningFor} (${candidate.party})', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700])),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit_note, color: Constants.primaryColor.withOpacity(0.8)),
                          tooltip: 'Edit',
                          onPressed: () => _showCandidateForm(candidate: candidate),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red.shade600),
                          tooltip: 'Delete',
                          onPressed: () => _deleteCandidate(candidate.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCandidateForm(),
        backgroundColor: Constants.primaryColor,
        icon: const Icon(Icons.add, color: Constants.secondaryColor),
        label: Text('Add Candidate', style: GoogleFonts.inter(color: Constants.secondaryColor, fontWeight: FontWeight.w600)),
      ),
    );
  }
}