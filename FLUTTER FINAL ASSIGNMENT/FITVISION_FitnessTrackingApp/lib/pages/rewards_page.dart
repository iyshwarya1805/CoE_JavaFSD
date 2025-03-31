// class RewardsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rewards & Challenges'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Consumer<RewardsProvider>(
//         builder: (context, rewardsProvider, child) {
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Points Card
//                   _buildPointsCard(rewardsProvider),
                  
//                   SizedBox(height: 20),
                  
//                   // Achievements Section
//                   Text(
//                     'Achievements',
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                   SizedBox(height: 10),
//                   _buildAchievementsGrid(rewardsProvider),
                  
//                   SizedBox(height: 20),
                  
//                   // Challenges Section
//                   Text(
//                     'Active Challenges',
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                   SizedBox(height: 10),
//                   _buildChallengesList(rewardsProvider),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPointsCard(RewardsProvider rewardsProvider) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Total Points',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${rewardsProvider.totalPoints}',
//               style: TextStyle(
//                 fontSize: 24, 
//                 fontWeight: FontWeight.bold, 
//                 color: Colors.deepPurple
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAchievementsGrid(RewardsProvider rewardsProvider) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: rewardsProvider.achievements.length,
//       itemBuilder: (context, index) {
//         final achievement = rewardsProvider.achievements[index];
//         return _buildAchievementItem(achievement);
//       },
//     );
//   }

//   Widget _buildAchievementItem(Achievement achievement) {
//     return Container(
//       decoration: BoxDecoration(
//         color: achievement.isUnlocked 
//           ? Colors.deepPurple[100] 
//           : Colors.grey[300],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             achievement.iconPath,
//             width: 50,
//             height: 50,
//             color: achievement.isUnlocked ? null : Colors.grey,
//           ),
//           SizedBox(height: 8),
//           Text(
//             achievement.title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 12,
//               color: achievement.isUnlocked 
//                 ? Colors.deepPurple 
//                 : Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildChallengesList(RewardsProvider rewardsProvider) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: rewardsProvider.challenges.length,
//       itemBuilder: (context, index) {
//         final challenge = rewardsProvider.challenges[index];
//         return _buildChallengeItem(challenge);
//       },
//     );
//   }

//   Widget _buildChallengeItem(FitnessChallenge challenge) {
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(12),
//         title: Text(
//           challenge.title,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(challenge.description),
//             SizedBox(height: 8),
//             Text(
//               'Reward: ${challenge.pointReward} Points',
//               style: TextStyle(color: Colors.green),
//             ),
//           ],
//         ),
//         trailing: Icon(
//           Icons.fitness_center,
//           color: Colors.deepPurple,
//         ),
//       ),
//     );
//   }
// }
