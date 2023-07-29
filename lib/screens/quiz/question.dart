import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:syi9a/admob/interAds.dart';
import '../../admob/admob.dart';
import '../../main.dart';

class QuizQuestion {
  final String idcategory;
  final String question;
  final List<String> choices;
  final List<int> correctChoices;

  QuizQuestion({
    required this.idcategory,
    required this.question,
    required this.choices,
    required this.correctChoices,
  });
}

class QuizPage extends StatefulWidget {
  final String category;
  const QuizPage({Key? key, required this.category}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<QuizQuestion> _quizQuestions;
  late int _currentQuestionIndex;
  late int _score = 0;
  late List<bool> _selectedChoices;
  int seconds = 30;
  Timer? timer, timer2;
  InterAds _interAds = InterAds();

  @override
  void initState() {
    AdHelper.bannerQuiz2.load();
    super.initState();
    _interAds.createInterstitialAd(AdHelper.interQuestion);
    _quizQuestions = [];
    _currentQuestionIndex = 0;
    startTimer();
    _selectedChoices = [];
    _fetchQuizQuestions();

    timer2 = Timer.periodic(const Duration(seconds: 180), (timer2) {
      _interAds.showInterstitialAd();
    });
  }

  final AdWidget adQuiz = AdWidget(ad: AdHelper.bannerQuiz2);
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          _nextQuestion();
        }
      });
    });
  }

  void _fetchQuizQuestions() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('عذرا، لا يمكنك الدخول ، تأكد من اتصالك بالأنترنت.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp())),
                child: Text('موافق'),
              ),
            ],
          );
        },
      );
    } else {
      final response = await http
          .get(Uri.parse('https://elhassandouki.github.io/quiz.json'));
      print(response);
      final List<dynamic> data = jsonDecode(response.body);
      final List<QuizQuestion> questions = data
          .map((json) {
            return QuizQuestion(
              idcategory: json['category'],
              question: json['question'],
              choices: List<String>.from(json['choices']),
              correctChoices: List<int>.from(json['correct_choices']),
            );
          })
          // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
          .where((QuizQuestion) => QuizQuestion.idcategory == widget.category)
          .toList();
      setState(() {
        _quizQuestions = questions;
        _selectedChoices = List.generate(
            questions[_currentQuestionIndex].choices.length, (_) => false);
      });
    }
  }

  void _submitAnswer() {
    final selectedChoices = _selectedChoices
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key + 1)
        .toList();
    final correctChoices = _quizQuestions[_currentQuestionIndex].correctChoices;

    final isCorrect = selectedChoices.length == correctChoices.length &&
        selectedChoices.every((choice) => correctChoices.contains(choice));
    if (isCorrect) {
      setState(() {
        _score++; // Increment the score if the answer is correct
      });
    }
    _nextQuestion();
  }

  void _showResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            title: Text(
              'النتيجة',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'نتيجتك هي $_score على ${_quizQuestions.length}',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff3354a1)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('سلاسل الامتحان'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedChoices = List.generate(
            _quizQuestions[_currentQuestionIndex].choices.length, (_) => false);
        timer!.cancel();
        seconds = 30;
        startTimer();
      });
    } else {
      timer!.cancel();
      //_interAds.showInterstitialAd();
      // Quiz is finished, do something like showing a summary or resetting the quiz
      _showResults();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_quizQuestions.isEmpty) {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final currentQuestion = _quizQuestions[_currentQuestionIndex];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          'الامتحان',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.keyboard_backspace),
              onPressed: () {
                timer!.cancel();
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text("$seconds",
                  style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  value: seconds / 30,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: /*Image.network(
              currentQuestion.question,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),*/
                SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 5,
              width: MediaQuery.of(context).size.width * 19 / 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  currentQuestion.question,
                ),
              ),
            ),
          ),
          ...List.generate(
            currentQuestion.choices.length,
            (index) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: CheckboxListTile(
                    title: Text(currentQuestion.choices[index]),
                    activeColor: Colors.green,
                    tileColor: Colors.grey,
                    value: _selectedChoices[index],
                    onChanged: (value) {
                      setState(() {
                        _selectedChoices[index] = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            child: SizedBox(
              height: 50,
              width: 320,
              child: adQuiz,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff3354a1)),
              ),
              onPressed: _submitAnswer,
              child: const Text('تأكيد'),
            ),
          ),
        ],
      ),
    );
  }
}
