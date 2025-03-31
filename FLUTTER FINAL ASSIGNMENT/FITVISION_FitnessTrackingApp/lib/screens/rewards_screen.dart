import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rewards_provider.dart';
import '../models/reward_model.dart';

class RewardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards'),
      ),
      body: Consumer<RewardsProvider>(
        builder: (context, rewardsProvider, child) {
          if (rewardsProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Points Display
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.stars, color: Colors.amber, size: 36),
                      SizedBox(width: 10),
                      Text(
                        '${rewardsProvider.points} Points',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20),
                
                Text(
                  'Available Rewards',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(height: 10),
                
                Expanded(
                  child: rewardsProvider.availableRewards.isEmpty
                      ? Center(child: Text('No rewards available yet!'))
                      : ListView.builder(
                          itemCount: rewardsProvider.availableRewards.length,
                          itemBuilder: (context, index) {
                            final reward = rewardsProvider.availableRewards[index];
                            return _buildRewardCard(context, reward, rewardsProvider);
                          },
                        ),
                ),
                
                SizedBox(height: 20),
                
                Text(
                  'Redeemed Rewards',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(height: 10),
                
                Expanded(
                  child: rewardsProvider.redeemedRewards.isEmpty
                      ? Center(child: Text('No redeemed rewards yet!'))
                      : ListView.builder(
                          itemCount: rewardsProvider.redeemedRewards.length,
                          itemBuilder: (context, index) {
                            final reward = rewardsProvider.redeemedRewards[index];
                            return _buildRedeemedRewardCard(context, reward);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildRewardCard(BuildContext context, Reward reward, RewardsProvider provider) {
    final bool canRedeem = provider.points >= reward.pointCost;
    
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.card_giftcard, color: Colors.white),
        ),
        title: Text(reward.title),
        subtitle: Text(reward.description),
        trailing: ElevatedButton(
          child: Text('${reward.pointCost} pts'),
          style: ElevatedButton.styleFrom(
            backgroundColor: canRedeem ? Colors.green : Colors.grey,
          ),
          onPressed: canRedeem
              ? () async {
                  final success = await provider.redeemReward(reward);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Reward redeemed successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to redeem reward.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              : null,
        ),
      ),
    );
  }
  
  Widget _buildRedeemedRewardCard(BuildContext context, Reward reward) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.check, color: Colors.white),
        ),
        title: Text(reward.title),
        subtitle: Text(reward.description),
        trailing: Text(
          'Redeemed',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}