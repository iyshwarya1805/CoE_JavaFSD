import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class ProgressChartsScreen extends StatefulWidget {
  @override
  _ProgressChartsScreenState createState() => _ProgressChartsScreenState();
}

class WorkoutSession {
  final DateTime date;
  final int duration; // in seconds
  final String exerciseType;
  final int caloriesBurned;
  final int heartRate; // average heart rate during workout

  WorkoutSession({
    required this.date, 
    required this.duration, 
    required this.exerciseType,
    required this.caloriesBurned,
    required this.heartRate,
  });
}

class _ProgressChartsScreenState extends State<ProgressChartsScreen> with SingleTickerProviderStateMixin {
  List<WorkoutSession> _workoutSessions = [];
  late TabController _tabController;
  bool _isLoading = true;
  final List<String> _exerciseIcons = ['🏃', '🏋️', '🧘', '⚡', '🚴'];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Simulate loading data
    Future.delayed(Duration(milliseconds: 800), () {
      _initializeDemoData();
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initializeDemoData() {
    if (_workoutSessions.isEmpty) {
      _generateInitialData();
    }
  }

  void _generateInitialData() {
    final now = DateTime.now();
    final random = math.Random();
    
    for (int i = 14; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      
      final baseMinutes = 15 + random.nextInt(10);
      final variation = i % 5;
      final exerciseType = _getRandomExerciseType();
      
      _workoutSessions.add(
        WorkoutSession(
          date: date,
          duration: (baseMinutes + variation) * 60,
          exerciseType: exerciseType,
          caloriesBurned: 100 + random.nextInt(300),
          heartRate: 120 + random.nextInt(40),
        )
      );
    }
  }

  String _getRandomExerciseType() {
    final exercises = [
      'Cardio', 
      'Strength Training', 
      'Yoga', 
      'HIIT', 
      'Cycling'
    ];
    return exercises[math.Random().nextInt(exercises.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracker'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              Future.delayed(Duration(milliseconds: 600), () {
                _workoutSessions.clear();
                _generateInitialData();
                setState(() {
                  _isLoading = false;
                });
              });
            },
          ),
        ],
      ),
      body: _isLoading 
        ? _buildLoadingState()
        : (_workoutSessions.isEmpty 
          ? _buildEmptyState()
          : _buildProgressCharts()),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Loading your fitness data...', 
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fitness_center, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'Start tracking your workouts to see progress!',
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(Icons.add_chart),
            label: Text('Generate Sample Data'),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              Future.delayed(Duration(milliseconds: 600), () {
                _initializeDemoData();
                setState(() {
                  _isLoading = false;
                });
              });
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProgressCharts() {
    return Column(
      children: [
        _buildProgressSummary(),
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).colorScheme.secondary,
          tabs: [
            Tab(icon: Icon(Icons.timer), text: 'Duration'),
            Tab(icon: Icon(Icons.pie_chart), text: 'Types'),
            Tab(icon: Icon(Icons.favorite), text: 'Heart Rate'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildWorkoutDurationChart(),
                    _buildCaloriesBurnedChart(),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildExerciseTypeChart(),
                    _buildExerciseList(),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeartRateChart(),
                    _buildInsightCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSummary() {
    // Calculate weekly progress
    final int totalMinutes = _workoutSessions.fold(0, (sum, session) => sum + session.duration) ~/ 60;
    final int totalCalories = _workoutSessions.fold(0, (sum, session) => sum + session.caloriesBurned);
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Text(
            '2-Week Progress Summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSummaryItem(
                icon: Icons.timer,
                value: '$totalMinutes',
                label: 'Minutes',
              ),
              _buildSummaryItem(
                icon: Icons.local_fire_department,
                value: '$totalCalories',
                label: 'Calories',
              ),
              _buildSummaryItem(
                icon: Icons.calendar_today,
                value: '${_workoutSessions.length}',
                label: 'Workouts',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutDurationChart() {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Workout Duration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.timer, color: Theme.of(context).colorScheme.primary),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index % 3 == 0 && index < _workoutSessions.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(_getDateLabel(index), 
                                style: TextStyle(fontSize: 10)),
                            );
                          }
                          return SizedBox.shrink();
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                      left: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _workoutSessions.asMap().entries.map((entry) {
                        return FlSpot(
                          entry.key.toDouble(), 
                          entry.value.duration / 60.0
                        );
                      }).toList(),
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaloriesBurnedChart() {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calories Burned',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.local_fire_department, color: Colors.orange),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _workoutSessions.map((s) => s.caloriesBurned.toDouble()).reduce(math.max) * 1.2,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index % 3 == 0 && index < _workoutSessions.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(_getDateLabel(index), 
                                style: TextStyle(fontSize: 10)),
                            );
                          }
                          return SizedBox.shrink();
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                      left: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  barGroups: _workoutSessions.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.caloriesBurned.toDouble(),
                          color: Colors.orange.shade400,
                          width: 12,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseTypeChart() {
    // Calculate exercise type distribution
    final exerciseTypeCount = <String, int>{};
    for (var session in _workoutSessions) {
      exerciseTypeCount[session.exerciseType] = 
        (exerciseTypeCount[session.exerciseType] ?? 0) + 1;
    }

    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exercise Types',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.pie_chart, color: Theme.of(context).colorScheme.secondary),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: exerciseTypeCount.entries.map((entry) {
                    final index = ['Cardio', 'Strength Training', 'Yoga', 'HIIT', 'Cycling']
                        .indexOf(entry.key);
                    return PieChartSectionData(
                      value: entry.value.toDouble(),
                      title: '${(entry.value / _workoutSessions.length * 100).toStringAsFixed(0)}%',
                      titleStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      radius: 100,
                      badgeWidget: _buildPieChartBadge(index),
                      badgePositionPercentageOffset: 1.2,
                      color: _getColorForExerciseType(entry.key),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartBadge(int index) {
    if (index >= 0 && index < _exerciseIcons.length) {
      return Text(
        _exerciseIcons[index],
        style: TextStyle(fontSize: 22),
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildExerciseList() {
    // Calculate total time per exercise type
    final exerciseTimeMap = <String, int>{};
    for (var session in _workoutSessions) {
      exerciseTimeMap[session.exerciseType] = 
        (exerciseTimeMap[session.exerciseType] ?? 0) + session.duration;
    }

    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exercise Breakdown',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ...exerciseTimeMap.entries.map((entry) {
              final index = ['Cardio', 'Strength Training', 'Yoga', 'HIIT', 'Cycling']
                  .indexOf(entry.key);
              final icon = index >= 0 && index < _exerciseIcons.length 
                  ? _exerciseIcons[index] 
                  : '🏋️';
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getColorForExerciseType(entry.key).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(icon, style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${entry.value ~/ 60} minutes total',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _getColorForExerciseType(entry.key),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${(entry.value / _workoutSessions.fold(0, (sum, session) => sum + session.duration) * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeartRateChart() {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Average Heart Rate',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.favorite, color: Colors.red),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index % 3 == 0 && index < _workoutSessions.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(_getDateLabel(index), 
                                style: TextStyle(fontSize: 10)),
                            );
                          }
                          return SizedBox.shrink();
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                      left: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _workoutSessions.asMap().entries.map((entry) {
                        return FlSpot(
                          entry.key.toDouble(), 
                          entry.value.heartRate.toDouble()
                        );
                      }).toList(),
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Colors.red,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.red.withOpacity(0.15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDateLabel(int index) {
    if (index >= 0 && index < _workoutSessions.length) {
      final date = _workoutSessions[index].date;
      return '${date.day}/${date.month}';
    }
    return '';
  }

  Color _getColorForExerciseType(String exerciseType) {
    switch (exerciseType) {
      case 'Cardio':
        return Color(0xFFFF5252); // red
      case 'Strength Training':
        return Color(0xFF4CAF50); // green
      case 'Yoga':
        return Color(0xFF9C27B0); // purple
      case 'HIIT':
        return Color(0xFFFF9800); // orange
      case 'Cycling':
        return Color(0xFF2196F3); // blue
      default:
        return Colors.grey;
    }
  }

  Widget _buildInsightCard() {
    final totalWorkoutTime = _workoutSessions.fold(
      0, (sum, session) => sum + session.duration
    );
    final averageWorkoutTime = totalWorkoutTime / _workoutSessions.length;
    final totalCalories = _workoutSessions.fold(
      0, (sum, session) => sum + session.caloriesBurned
    );
    final avgHeartRate = _workoutSessions.fold(
      0, (sum, session) => sum + session.heartRate
    ) ~/ _workoutSessions.length;

    // Calculate trends
    bool isTimeIncreasing = false;
    if (_workoutSessions.length >= 2) {
      final firstHalf = _workoutSessions.sublist(0, _workoutSessions.length ~/ 2);
      final secondHalf = _workoutSessions.sublist(_workoutSessions.length ~/ 2);
      
      final firstHalfAvg = firstHalf.fold(0, (sum, s) => sum + s.duration) / firstHalf.length;
      final secondHalfAvg = secondHalf.fold(0, (sum, s) => sum + s.duration) / secondHalf.length;
      
      isTimeIncreasing = secondHalfAvg > firstHalfAvg;
    }

    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Progress Insights',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.insights, color: Theme.of(context).colorScheme.secondary),
              ],
            ),
            SizedBox(height: 16),
            _buildInsightItem(
              icon: Icons.timer,
              title: 'Workout Duration',
              value: '${averageWorkoutTime ~/ 60} minutes avg',
              trend: isTimeIncreasing ? 'Increasing 🔼' : 'Stable ➡️',
            ),
            Divider(),
            _buildInsightItem(
              icon: Icons.local_fire_department,
              title: 'Total Calories Burned',
              value: '$totalCalories calories',
              trend: 'Last 2 weeks',
            ),
            Divider(),
            _buildInsightItem(
              icon: Icons.favorite,
              title: 'Average Heart Rate',
              value: '$avgHeartRate BPM',
              trend: 'During workouts',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightItem({
    required IconData icon,
    required String title,
    required String value,
    required String trend,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              trend,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}