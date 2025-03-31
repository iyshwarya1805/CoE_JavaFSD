import 'package:flutter/material.dart';
import '../models/challenge_model.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final VoidCallback onToggleComplete;

  const ChallengeCard({
    Key? key,
    required this.challenge,
    required this.onToggleComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    challenge.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: challenge.isCompleted ? Colors.green : Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${challenge.points} pts',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              challenge.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress: ${challenge.currentProgress}/${challenge.targetValue} ${challenge.metric}',
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: challenge.progressPercentage,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          challenge.isCompleted ? Colors.green : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                if (!challenge.isCompleted)
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline),
                    onPressed: onToggleComplete,
                    tooltip: 'Mark as completed',
                  ),
              ],
            ),
            if (challenge.rewards.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                'Rewards:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                children: challenge.rewards.map((reward) => Chip(
                  label: Text(reward),
                  backgroundColor: Colors.green.shade100,
                )).toList(),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ends: ${_formatDate(challenge.endDate)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                if (challenge.isCompleted)
                  const Chip(
                    label: Text('Completed!'),
                    backgroundColor: Colors.green,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}