import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

// Imports
import 'exercise_category_page.dart';
import 'pages/nutrition_tracking_page.dart';
import 'screens/progress_charts_screen.dart';
import 'providers/rewards_provider.dart';
import 'providers/language_provider.dart';
import 'screens/rewards_screen.dart';
import 'screens/challenges_screen.dart';
import 'pages/safety_tips_page.dart';
import 'models/challenge_model.dart';
import 'models/reward_model.dart';
import 'l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // Controllers
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  
  // Animation controller for activity icons
  late AnimationController _animationController;
  late Animation<double> _animation;

  // State variables
  String _motivationalQuote = 'Click to get motivated!';
  bool _isLoading = false;

  // Firebase references
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Set current date by default
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  // Fetch Motivational Quote
  Future<void> _fetchMotivationalQuote() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final response = await http.get(
        Uri.parse('https://zenquotes.io/api/random'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> quoteData = json.decode(response.body);
        if (quoteData.isNotEmpty) {
          setState(() {
            _motivationalQuote = '"${quoteData[0]['q']}" - ${quoteData[0]['a']}';
          });
        }
      } else {
        setState(() {
          _motivationalQuote = 'Failed to fetch quote. Try again!';
        });
      }
    } catch (e) {
      setState(() {
        _motivationalQuote = 'Network error. Check your connection.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Save Weight and Date to Firestore
  void _saveWeightData() async {
    final localizations = AppLocalizations.of(context);
    
    // Parse inputs
    final weight = double.tryParse(_weightController.text);
    final date = _dateController.text;

    // Validate inputs
    if (weight != null && date.isNotEmpty) {
      try {
        // Save to Firestore
        await _firestore.collection('weight_tracking').add({
          'weight': weight,
          'date': date,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.translate('weightSaved')),
            backgroundColor: Colors.green,
          ),
        );

        // Clear controllers
        _weightController.clear();
        _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${localizations.translate('weightSaveError')}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Show validation error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.translate('invalidInput')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Show completion dialog for a challenge
  void _showCompletionDialog(BuildContext context, Challenge challenge) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Challenge Completed!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Congratulations! You completed: ${challenge.title}'),
              SizedBox(height: 10),
              Text('You earned ${challenge.points} points!'),
              _buildRewardsList('Rewards:', challenge.rewards),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Helper method to build rewards list
  Widget _buildRewardsList(String title, List rewardsList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        ...rewardsList.map((reward) => Text('• $reward')).toList(),
      ],
    );
  }

  // Language selector
  void _showLanguageSelector() {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLanguageOption('English', 'en', languageProvider),
                _buildLanguageOption('Español', 'es', languageProvider),
                _buildLanguageOption('Français', 'fr', languageProvider),
                _buildLanguageOption('हिन्दी', 'hi', languageProvider),
                _buildLanguageOption('தமிழ்', 'ta', languageProvider),
                _buildLanguageOption('తెలుగు', 'te', languageProvider),
              ],
            ),
          ),
        );
      }
    );
  }
  
  Widget _buildLanguageOption(String name, String code, LanguageProvider provider) {
    return ListTile(
      title: Text(name),
      onTap: () {
        provider.changeLanguage(Locale(code));
        Navigator.of(context).pop();
      },
      trailing: provider.currentLocale.languageCode == code ? Icon(Icons.check, color: Colors.green) : null,
    );
  }

  // Build a fitness activity tile
  Widget _buildActivityTile(IconData icon, String title, String subtitle, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }

  // Build the animated fitness icons row
  Widget _buildAnimatedIconsRow() {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAnimatedIcon(FontAwesomeIcons.personRunning, 'Cardio'),
          _buildAnimatedIcon(FontAwesomeIcons.dumbbell, 'Strength'),
          _buildAnimatedIcon(FontAwesomeIcons.appleWhole, 'Nutrition'),
          _buildAnimatedIcon(FontAwesomeIcons.bed, 'Rest'),
          _buildAnimatedIcon(FontAwesomeIcons.heartPulse, 'Health'),
        ],
      ),
    );
  }

  // Build a single animated icon
  Widget _buildAnimatedIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _animation,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon, 
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.fitness_center, size: 24),
            SizedBox(width: 8),
            Text(
              "FITVISION",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: _showLanguageSelector,
            tooltip: 'Change Language',
          ),
        ],
      ),
      // Drawer for Navigation
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade50, Colors.white],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade500],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "FITVISION",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your fitness journey starts here",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(localizations.translate('home')),
                leading: Icon(Icons.home, color: Colors.blue.shade700),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(localizations.translate('exercises')),
                leading: Icon(Icons.directions_run, color: Colors.green.shade600),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseCategoryPage()),
                  );
                },
              ),
              ListTile(
                title: Text(localizations.translate('nutrition')),
                leading: Icon(Icons.restaurant_menu, color: Colors.orange.shade600),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NutritionPage()),
                  );
                },
              ),
              ListTile(
                title: Text(localizations.translate('rewards')),
                leading: Icon(Icons.card_giftcard, color: Colors.purple.shade600),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RewardsScreen()),
                  );
                },
              ),
              ListTile(
                title: Text(localizations.translate('challenges')),
                leading: Icon(Icons.emoji_events, color: Colors.amber.shade700),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChallengesPage()),
                  );
                },
              ),
              ListTile(
                title: Text(localizations.translate('safetyTips')),
                leading: Icon(Icons.health_and_safety, color: Colors.red.shade600),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SafetyTipsPage()),
                  );
                },
              ),
              ListTile(
                title: Text(localizations.translate('progressCharts')),
                leading: Icon(Icons.bar_chart, color: Colors.teal.shade600),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProgressChartsScreen()),
                  );
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "FITVISION © 2025",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header welcome section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue.shade50,
                          child: Icon(
                            Icons.person,
                            size: 36,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome to FITVISION",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Track your fitness journey and achieve your goals",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Motivational Quote Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.format_quote,
                              color: Colors.blue.shade700,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Daily Motivation",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        _isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                _motivationalQuote,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _fetchMotivationalQuote,
                          icon: Icon(Icons.refresh),
                          label: Text(localizations.translate('getMotivation')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Weight Tracking Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.monitor_weight,
                              color: Colors.green.shade600,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Weight Tracker",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        
                        // Date Input
                        TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: localizations.translate('date'),
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green.shade600, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green.shade300),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Colors.green.shade600,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                _dateController.text = formattedDate;
                              });
                            }
                          },
                        ),

                        SizedBox(height: 20),

                        // Weight Input
                        TextField(
                          controller: _weightController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: localizations.translate('weight'),
                            prefixIcon: Icon(Icons.monitor_weight),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green.shade600, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green.shade300),
                            ),
                            suffixText: 'kg',
                          ),
                        ),

                        SizedBox(height: 20),

                        // Save Button
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: _saveWeightData,
                            icon: Icon(Icons.save),
                            label: Text(localizations.translate('saveWeight')),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade600,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
                
                // Quick Access Section
                // Card(
                //   elevation: 4,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           children: [
                //             Icon(
                //               Icons.bolt,
                //               color: Colors.orange.shade700,
                //               size: 24,
                //             ),
                //             SizedBox(width: 8),
                //             Text(
                //               "Quick Access",
                //               style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.orange.shade700,
                //               ),
                //             ),
                //           ],
                //         ),
                //         SizedBox(height: 16),
                //         _buildActivityTile(
                //           Icons.directions_run,
                //           "Today's Workout",
                //           "Start your daily exercise routine",
                //           Colors.blue.shade700,
                //         ),
                //         _buildActivityTile(
                //           Icons.restaurant_menu,
                //           "Meal Planner",
                //           "Plan your healthy meals",
                //           Colors.green.shade600,
                //         ),
                //         _buildActivityTile(
                //           Icons.emoji_events,
                //           "Active Challenges",
                //           "See your ongoing fitness challenges",
                //           Colors.amber.shade700,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                SizedBox(height: 20),
                
                // Animated Fitness Icons Row
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        Text(
                          "FITNESS ELEMENTS",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildAnimatedIconsRow(),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _weightController.dispose();
    _dateController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}