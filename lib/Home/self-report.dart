// import 'package:allia_health/Home/submit-report.dart';
// import 'package:flutter/material.dart';
// import '../Service/login-repo.dart';
// import '../Service/self-report-service.dart';

// class SelfReportScreen extends StatefulWidget {
//   final ApiService apiService;

//   SelfReportScreen({required this.apiService});

//   @override
//   _SelfReportScreenState createState() => _SelfReportScreenState();
// }

// class _SelfReportScreenState extends State<SelfReportScreen> {
//   late Future<List<Question>> futureQuestions;

//   @override
//   void initState() {
//     super.initState();
//     futureQuestions = SelfReportService(accessToken: widget.apiService.accessToken!).getQuestions();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFAF7F2), // Background color similar to the image
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           'Self Report',
//           style: TextStyle(color: Colors.black),
//         ),
//         iconTheme: IconThemeData(color: Colors.black),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<List<Question>>(
//         future: futureQuestions,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No questions available'));
//           }

//           final question = snapshot.data!.first; // Display the first question
//           return QuestionWidget(question: question);
//         },
//       ),
//     );
//   }
// }

// class QuestionWidget extends StatelessWidget {
//   final Question question;

//   QuestionWidget({required this.question});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'How are you feeling?',
//             style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 8.0),
//           Text(
//             'Select the number that best represents your Excitement level.',
//             style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20.0),
//           Expanded(
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: question.options.length,
//               itemBuilder: (context, index) {
//                 final option = question.options[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SubmitReportScreen(
//                           apiService: ApiService(),
//                           question: question,
//                           selectedOption: option,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: OptionCard(option: option),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 20.0),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               shape: CircleBorder(), backgroundColor: Color(0xFF34C759),
//               padding: EdgeInsets.all(16), // Button color similar to the image
//             ),
//             child: Icon(Icons.arrow_forward, size: 32),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class OptionCard extends StatelessWidget {
//   final Option option;

//   OptionCard({required this.option});

//   final Map<String, String> emojiMap = {
//     'Angry': '😡',
//     'Happy': '😊',
//     'Frustrated': '😤',
//     'Excited': '😃',
//     'Sad': '😢',
//     'Peaceful': '😌',
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 4.0,
//       child: Container(
//         width: 150,
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               emojiMap[option.option] ?? '❓', // Display the corresponding emoji
//               style: TextStyle(fontSize: 64),
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               option.option,
//               style: TextStyle(fontSize: 20.0, color: Color(0xFFB39B7B)), // Text color similar to the image
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:allia_health/Home/submit-report.dart';
import 'package:flutter/material.dart';
import '../Service/login-repo.dart';
import '../Service/self-report-service.dart';


class SelfReportScreen extends StatefulWidget {
  final ApiService apiService;

  SelfReportScreen({required this.apiService});

  @override
  _SelfReportScreenState createState() => _SelfReportScreenState();
}

class _SelfReportScreenState extends State<SelfReportScreen> {
  late Future<List<Question>> futureQuestions;

  @override
  void initState() {
    super.initState();
    futureQuestions = SelfReportService(accessToken: widget.apiService.accessToken!).getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF7F2), // Background color similar to the image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Self Report',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Question>>(
        future: futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No questions available'));
          }

          final question = snapshot.data!.first; // Display the first question
          return QuestionWidget(
            question: question,
            apiService: widget.apiService,
          );
        },
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final Question question;
  final ApiService apiService;

  QuestionWidget({required this.question, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'How are you feeling?',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          Text(
            'Select the number that best represents your Excitement level.',
            style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                final option = question.options[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubmitReportScreen(
                          apiService: apiService,
                          question: question,
                          selectedOption: option,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: OptionCard(option: option),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(), backgroundColor: Color(0xFF34C759),
              padding: EdgeInsets.all(16), // Button color similar to the image
            ),
            child: Icon(Icons.arrow_forward, size: 32),
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final Option option;

  OptionCard({required this.option});

  final Map<String, String> emojiMap = {
    'Angry': '😡',
    'Happy': '😊',
    'Frustrated': '😤',
    'Excited': '😃',
    'Sad': '😢',
    'Peaceful': '😌',
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4.0,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emojiMap[option.option] ?? '❓',
              style: TextStyle(
                fontSize: 64,
                color: Colors.black, // Ensure the color is explicitly set to black or appropriate
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              option.option,
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFFB39B7B), // Text color similar to the image
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
