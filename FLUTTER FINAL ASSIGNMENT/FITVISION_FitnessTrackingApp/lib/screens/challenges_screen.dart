import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/challenge_model.dart';
import '../widgets/challenge_card.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({Key? key}) : super(key: key);

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _challengesStream;

  @override
  void initState() {
    super.initState();
    _challengesStream = _firestore.collection('challenges').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _challengesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final challenges = snapshot.data?.docs ?? [];

                if (challenges.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'No challenges available yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _addSampleData,
                        child: const Text('Add Sample Challenges'),
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  itemCount: challenges.length,
                  itemBuilder: (context, index) {
                    final challengeDoc = challenges[index];
                    final data = challengeDoc.data() as Map<String, dynamic>;
                    
                    // Create Challenge object from Firestore data
                    final challenge = Challenge.fromMap(data, challengeDoc.id);
                    
                    return ChallengeCard(
                      challenge: challenge,
                      onToggleComplete: () => _toggleChallengeComplete(challenge.id, challenge.isCompleted),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSampleData,
        tooltip: 'Add Sample Challenges',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addSampleData() async {
    try {
      // Add sample challenges
      await _firestore.collection('challenges').add({
        'title': "Run 5K",
        'description': "Complete a 5K run within 30 minutes",
        'points': 100,
        'rewards': ["Free protein shake", "Running badge"],
        'isCompleted': false,
        'currentProgress': 0,
        'targetValue': 5,
        'metric': 'km',
        'endDate': Timestamp.fromDate(DateTime.now().add(const Duration(days: 30))),
      });
      
      await _firestore.collection('challenges').add({
        'title': "30-Day Plank Challenge",
        'description': "Do a plank every day for 30 days, increasing time by 5 seconds each day",
        'points': 200,
        'rewards': ["Core strength badge", "Premium workout plan"],
        'isCompleted': false,
        'currentProgress': 0,
        'targetValue': 30,
        'metric': 'days',
        'endDate': Timestamp.fromDate(DateTime.now().add(const Duration(days: 30))),
      });
      
      // Add sample rewards
      await _firestore.collection('rewards').add({
        'title': "Protein Shaker",
        'description': "Premium protein shaker bottle",
        'pointCost': 150,
        'imageUrl': "https://example.com/shaker.jpg"
      });
      
      await _firestore.collection('rewards').add({
        'title': "Fitness T-shirt",
        'description': "Moisture-wicking performance t-shirt",
        'pointCost': 300,
        'imageUrl': "https://example.com/tshirt.jpg"
      });
      
      // Add user progress
      await _firestore.collection('user_progress').doc('current_user').set({
        'points': 50
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sample data added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding sample data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _toggleChallengeComplete(String challengeId, bool currentStatus) async {
    try {
      await _firestore.collection('challenges').doc(challengeId).update({
        'isCompleted': !currentStatus,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating challenge: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}