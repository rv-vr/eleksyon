import 'package:eleksyon/features/admin/candidate_management.dart';
import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // blue banner, name, role
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40, bottom: 30),
              decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.lightBlueAccent, width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/pfp.jpg'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Key',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Super Admin',
                    style: TextStyle(
                      color: Color.fromARGB(199, 255, 255, 255),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'The Super Admin oversees the election system, manages users and candidates, and ensures secure and smooth operations.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // grid layout with icons and labelsssss
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _statCard('Registered Voters', '1250', Icons.person),
                  _statCard('Votes Cast', '800', Icons.how_to_vote),
                  _statCard('Candidates', '2', Icons.diversity_1),
                  _actionCard(context, 'User Management', Icons.groups, null),
                  _actionCard(context, 'Candidate Management', Icons.person_search, CandidateManagementPage()),
                  _actionCard(context, 'Results', Icons.bar_chart, null),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //design
  Widget _statCard(String title, String value, IconData icon) {
    return Card(
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blue.shade700),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 20, color: Colors.blue.shade900)),
          ],
        ),
      ),
    );
  }

  Widget _actionCard(BuildContext context, String label, IconData icon, Widget? dest) {
    return GestureDetector(
      onTap: () {
        if (dest != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => dest));
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label clicked')));
      },
      child: Card(
        color: Colors.blue.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.blue.shade700),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
