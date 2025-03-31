import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reward_model.dart';

class RewardsProvider with ChangeNotifier {
  int _points = 0;
  List<Reward> _availableRewards = [];
  List<Reward> _redeemedRewards = [];
  bool _isLoading = false;

  // Getters
  int get points => _points;
  List<Reward> get availableRewards => _availableRewards;
  List<Reward> get redeemedRewards => _redeemedRewards;
  bool get isLoading => _isLoading;

  // Load user progress from Firestore
  Future<void> loadProgress() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Load points
      final userDoc = await FirebaseFirestore.instance
          .collection('user_progress')
          .doc('current_user') // Replace with actual user ID in production
          .get();
      
      if (userDoc.exists) {
        _points = userDoc.data()?['points'] ?? 0;
      }
      
      // Load rewards
      final rewardsSnapshot = await FirebaseFirestore.instance
          .collection('rewards')
          .get();
      
      _availableRewards = rewardsSnapshot.docs
          .map((doc) => Reward.fromMap(doc.data(), doc.id))
          .toList();
      
      // Load redeemed rewards
      final redeemedSnapshot = await FirebaseFirestore.instance
          .collection('user_progress')
          .doc('current_user') // Replace with actual user ID in production
          .collection('redeemed_rewards')
          .get();
      
      _redeemedRewards = redeemedSnapshot.docs
          .map((doc) => Reward.fromMap(doc.data(), doc.id))
          .toList();
      
    } catch (e) {
      print('Error loading progress: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Add points
  Future<void> addPoints(int amount) async {
    _points += amount;
    
    try {
      await FirebaseFirestore.instance
          .collection('user_progress')
          .doc('current_user') // Replace with actual user ID in production
          .set({'points': _points}, SetOptions(merge: true));
    } catch (e) {
      print('Error adding points: $e');
      // Rollback on error
      _points -= amount;
    }
    
    notifyListeners();
  }
  
  // Redeem a reward
  Future<bool> redeemReward(Reward reward) async {
    if (_points < reward.pointCost) {
      return false;
    }
    
    try {
      // Deduct points
      _points -= reward.pointCost;
      await FirebaseFirestore.instance
          .collection('user_progress')
          .doc('current_user') // Replace with actual user ID in production
          .set({'points': _points}, SetOptions(merge: true));
      
      // Add to redeemed rewards
      await FirebaseFirestore.instance
          .collection('user_progress')
          .doc('current_user') // Replace with actual user ID in production
          .collection('redeemed_rewards')
          .add(reward.toMap());
      
      _redeemedRewards.add(reward);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error redeeming reward: $e');
      // Rollback on error
      _points += reward.pointCost;
      notifyListeners();
      return false;
    }
  }
}