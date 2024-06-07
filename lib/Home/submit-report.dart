import 'package:flutter/material.dart';
import '../Service/login-repo.dart';
import '../Service/self-report-service.dart';
import '../Service/submit-report-service.dart';
import 'success-screen.dart';


class SubmitReportScreen extends StatefulWidget {
  final ApiService apiService;
  final Question question;
  final Option selectedOption;

  SubmitReportScreen({
    required this.apiService,
    required this.question,
    required this.selectedOption,
  });

  @override
  _SubmitReportScreenState createState() => _SubmitReportScreenState();
}

class _SubmitReportScreenState extends State<SubmitReportScreen> {
  late Option selectedOption;
  double excitementLevel = 5;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOption;
  }

  Future<void> _submitAnswer() async {
    try {
      print('AccessToken: ${widget.apiService.accessToken}');
      print('QuestionId: ${widget.question.id}');
      print('SelectedOptionId: ${selectedOption.id}');

      await SubmitReportService.submitReport(
        accessToken: widget.apiService.accessToken!,
        questionId: int.parse(widget.question.id),
        selectedOptionId: int.parse(selectedOption.id),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SuccessScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit answer: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF7F2), // Background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You're feeling",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              selectedOption.option,
              style: TextStyle(
                fontSize: 24.0,
                color: Color(0xFFB39B7B),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Select the number that best represents your Excitement level.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Color(0xFF34C759),
                        inactiveTrackColor: Colors.grey[300],
                        trackHeight: 8.0,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                        thumbColor: Colors.transparent,
                        overlayColor: Colors.transparent,
                        activeTickMarkColor: Colors.transparent,
                        inactiveTickMarkColor: Colors.transparent,
                      ),
                      child: Slider(
                        value: excitementLevel,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        onChanged: (value) {
                          setState(() {
                            excitementLevel = value;
                          });
                        },
                        label: getEmoji(selectedOption.option),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    child: Container(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getEmoji(selectedOption.option),
                            style: TextStyle(
                              fontSize: 64,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitAnswer,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Color(0xFF34C759),
                padding: EdgeInsets.all(16),
              ),
              child: Icon(Icons.arrow_forward, size: 32),
            ),
          ],
        ),
      ),
    );
  }

  String getEmoji(String option) {
    switch (option) {
      case 'Angry':
        return '😡';
      case 'Happy':
        return '😊';
      case 'Frustrated':
        return '😤';
      case 'Excited':
        return '😃';
      case 'Sad':
        return '😢';
      case 'Peaceful':
        return '😌';
      default:
        return '❓';
    }
  }
}
