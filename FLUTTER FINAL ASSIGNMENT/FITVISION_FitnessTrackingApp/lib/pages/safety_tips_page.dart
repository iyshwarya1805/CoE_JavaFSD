import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class SafetyTipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('safetyTips')),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, localizations),
                SizedBox(height: 16),
                _buildTipSection(
                  context,
                  'Warm Up & Cool Down',
                  'Always spend 5-10 minutes warming up before exercise and cooling down afterward to prevent injuries.',
                  Icons.accessibility_new,
                  Colors.orange.shade700,
                ),
                _buildTipSection(
                  context,
                  'Stay Hydrated',
                  'Drink water before, during, and after workouts. Don\'t wait until you feel thirsty to drink.',
                  Icons.water_drop,
                  Colors.blue.shade600,
                ),
                _buildTipSection(
                  context,
                  'Proper Form',
                  'Focus on proper technique rather than lifting heavy weights or doing more repetitions. Poor form can lead to injuries.',
                  Icons.fitness_center,
                  Colors.green.shade700,
                ),
                _buildTipSection(
                  context,
                  'Listen to Your Body',
                  'Learn the difference between discomfort from a good workout and pain that signals potential injury.',
                  Icons.monitor_heart,
                  Colors.red.shade600,
                ),
                _buildTipSection(
                  context,
                  'Rest & Recovery',
                  'Give your body time to recover between workouts. Muscles grow and repair during rest periods.',
                  Icons.hotel,
                  Colors.indigo.shade600,
                ),
                _buildTipSection(
                  context,
                  'Progressive Overload',
                  'Gradually increase intensity over time instead of making dramatic changes to your routine.',
                  Icons.trending_up,
                  Colors.purple.shade600,
                ),
                _buildTipSection(
                  context,
                  'Balanced Routine',
                  'Include a mix of cardiovascular, strength, flexibility, and balance exercises in your fitness routine.',
                  Icons.balance,
                  Colors.teal.shade600,
                ),
                SizedBox(height: 16),
                _buildFooterNote(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations localizations) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.health_and_safety,
              color: Theme.of(context).primaryColor,
              size: 36,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.translate('safetyTips'),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Train smart, stay safe, and maximize your results',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipSection(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color iconColor,
  ) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: iconColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: iconColor,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: _buildActionButton(title, iconColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String tipType, Color color) {
    String buttonText;
    IconData buttonIcon;
    
    switch (tipType) {
      case 'Warm Up & Cool Down':
        buttonText = 'Warm-up Guide';
        buttonIcon = Icons.play_arrow;
        break;
      case 'Stay Hydrated':
        buttonText = 'Hydration Calculator';
        buttonIcon = Icons.calculate;
        break;
      case 'Proper Form':
        buttonText = 'Form Videos';
        buttonIcon = Icons.video_library;
        break;
      case 'Listen to Your Body':
        buttonText = 'Pain vs. Soreness';
        buttonIcon = Icons.info_outline;
        break;
      case 'Rest & Recovery':
        buttonText = 'Recovery Tips';
        buttonIcon = Icons.restore;
        break;
      case 'Progressive Overload':
        buttonText = 'Learn More';
        buttonIcon = Icons.school;
        break;
      default:
        buttonText = 'Read More';
        buttonIcon = Icons.arrow_forward;
    }
    
    return TextButton.icon(
      icon: Icon(buttonIcon, size: 18, color: color),
      label: Text(
        buttonText,
        style: TextStyle(color: color),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color.withOpacity(0.3)),
        ),
        backgroundColor: color.withOpacity(0.05),
      ),
      onPressed: () {
        // Action to be implemented
      },
    );
  }

  Widget _buildFooterNote(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber.shade700),
              SizedBox(width: 8),
              Text(
                "Safety First!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Always consult with a healthcare professional before beginning any new exercise program, especially if you have pre-existing health conditions.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}