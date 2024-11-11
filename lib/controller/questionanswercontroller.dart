import 'package:hive/hive.dart';
import 'package:quizapp/db/choice_model.dart';
import 'package:quizapp/db/question_model.dart';

class Questionanswercontroller {
  Future<void> populateDummyQuestions() async {
    final questionBox = Hive.box<Question>('questionsBox');
    final choiceBox = Hive.box<Choice>('choicesBox');

    // questionBox.clear();
    // choiceBox.clear();

    final List<Map<String, dynamic>> questionsWithChoices = [
      {
        "question": "What language does Flutter use?",
        "correctAnswer": "Dart",
        "choices": ["Dart", "Java", "Swift", "Python"],
      },
      {
        "question": "What widget type is immutable?",
        "correctAnswer": "Stateless",
        "choices": ["Stateful", "Stateless", "Inherited", "Container"],
      },
      {
        "question": "What tool helps with fast UI refresh?",
        "correctAnswer": "Hot Reload",
        "choices": ["Hot Restart", "Debug", "Hot Reload", "Rebuild"],
      },
      {
        "question": "What widget type can update dynamically?",
        "correctAnswer": "Stateful",
        "choices": ["Stateful", "Container", "Stateless", "Inherited"],
      },
      {
        "question": "What company created Flutter?",
        "correctAnswer": "Google",
        "choices": ["Apple", "Google", "Microsoft", "Amazon"],
      },
      {
        "question":
            "Which programming language is used for Android development?",
        "correctAnswer": "Kotlin",
        "choices": ["Java", "Swift", "Kotlin", "Dart"],
      },
      {
        "question": "What type of widget is used to manage state in Flutter?",
        "correctAnswer": "StatefulWidget",
        "choices": [
          "StatelessWidget",
          "StatefulWidget",
          "InheritedWidget",
          "Container"
        ],
      },
      {
        "question": "Which of the following is not a widget in Flutter?",
        "correctAnswer": "Loop",
        "choices": ["Column", "Row", "Text", "Loop"],
      },
      {
        "question": "What is the purpose of the 'build' method in Flutter?",
        "correctAnswer": "To describe the UI",
        "choices": [
          "To update the state",
          "To describe the UI",
          "To initialize the app",
          "To handle events"
        ],
      },
      {
        "question":
            "Which widget in Flutter is used to create a scrollable list?",
        "correctAnswer": "ListView",
        "choices": ["Container", "Column", "ListView", "Row"],
      },
      {
        "question":
            "What is the default type of the main function in a Flutter app?",
        "correctAnswer": "void main()",
        "choices": [
          "void main()",
          "int main()",
          "Future<void> main()",
          "String main()"
        ],
      },
      {
        "question": "Which widget is used to create a button in Flutter?",
        "correctAnswer": "ElevatedButton",
        "choices": [
          "RaisedButton",
          "FlatButton",
          "ElevatedButton",
          "IconButton"
        ],
      },
      {
        "question": "Which package is used to handle HTTP requests in Flutter?",
        "correctAnswer": "http",
        "choices": ["url_launcher", "http", "path_provider", "sqflite"],
      },
      {
        "question": "Which function is used to run a Flutter app?",
        "correctAnswer": "runApp()",
        "choices": ["runApp()", "main()", "startApp()", "initializeApp()"],
      },
      {
        "question": "What type of programming paradigm does Flutter follow?",
        "correctAnswer": "Declarative UI",
        "choices": [
          "Imperative UI",
          "Declarative UI",
          "Procedural Programming",
          "Object-Oriented Programming"
        ],
      },
      {
        "question": "What is the purpose of the 'setState' method in Flutter?",
        "correctAnswer": "To notify the framework to rebuild the widget",
        "choices": [
          "To update the UI",
          "To notify the framework to rebuild the widget",
          "To fetch data from API",
          "To change state permanently"
        ],
      },
      {
        "question":
            "What is the main benefit of using Flutter for development?",
        "correctAnswer": "Single codebase for multiple platforms",
        "choices": [
          "Native performance",
          "Single codebase for multiple platforms",
          "Hot reload",
          "Rich set of widgets"
        ],
      },
      {
        "question":
            "Which widget is used to create a text input field in Flutter?",
        "correctAnswer": "TextField",
        "choices": ["TextField", "TextFormField", "FormField", "InputField"],
      },
      {
        "question":
            "Which method is used to navigate between screens in Flutter?",
        "correctAnswer": "Navigator.push()",
        "choices": [
          "Navigator.push()",
          "Navigator.pop()",
          "Navigator.replace()",
          "Navigator.goTo()"
        ],
      },
      {
        "question": "What package is used to work with databases in Flutter?",
        "correctAnswer": "sqflite",
        "choices": ["shared_preferences", "hive", "sqflite", "moor"],
      },
      {
        "question":
            "Which widget is used to display a loading spinner in Flutter?",
        "correctAnswer": "CircularProgressIndicator",
        "choices": [
          "ProgressIndicator",
          "LinearProgressIndicator",
          "CircularProgressIndicator",
          "LoadingSpinner"
        ],
      },
      {
        "question":
            "What is the purpose of 'pubspec.yaml' in a Flutter project?",
        "correctAnswer": "To manage project dependencies",
        "choices": [
          "To manage project dependencies",
          "To configure app theme",
          "To define routes",
          "To manage assets"
        ],
      },
      {
        "question": "Which is a popular state management solution for Flutter?",
        "correctAnswer": "Provider",
        "choices": ["Provider", "Redux", "BLoC", "All of the above"],
      },
      {
        "question":
            "Which widget is used to create an expandable list in Flutter?",
        "correctAnswer": "ExpansionTile",
        "choices": ["ListView", "ExpansionTile", "Column", "Row"],
      },
      {
        "question":
            "Which widget is used to create a drop-down menu in Flutter?",
        "correctAnswer": "DropdownButton",
        "choices": [
          "DropdownMenu",
          "DropdownButton",
          "PopupMenuButton",
          "ListView"
        ],
      },
      {
        "question": "What is the purpose of 'pub get' command in Flutter?",
        "correctAnswer": "To fetch dependencies",
        "choices": [
          "To install dependencies",
          "To fetch dependencies",
          "To create a build",
          "To update dependencies"
        ],
      },
      {
        "question": "Which widget is used to align a child widget in Flutter?",
        "correctAnswer": "Align",
        "choices": ["Positioned", "Align", "Center", "Padding"],
      },
      {
        "question": "What is the default text color in Flutter?",
        "correctAnswer": "Black",
        "choices": ["White", "Black", "Blue", "Gray"],
      },
      {
        "question":
            "Which widget is used to create a scrollable view of items in Flutter?",
        "correctAnswer": "ListView",
        "choices": ["ScrollView", "ListView", "GridView", "PageView"],
      },
      {
        "question":
            "Which widget is used to wrap a group of widgets together in Flutter?",
        "correctAnswer": "Container",
        "choices": ["Column", "Row", "Container", "Stack"],
      },
      {
        "question": "What does the 'setState' method do in Flutter?",
        "correctAnswer": "It triggers a rebuild of the widget",
        "choices": [
          "It triggers a rebuild of the widget",
          "It updates the database",
          "It runs the app",
          "It starts the UI thread"
        ],
      },
      {
        "question":
            "Which method is used to perform an asynchronous operation in Flutter?",
        "correctAnswer": "async/await",
        "choices": [
          "async/await",
          "Future.then()",
          "Stream.listen()",
          "Future.sync()"
        ],
      },
      {
        "question": "What is the use of the 'Navigator' widget in Flutter?",
        "correctAnswer": "To manage app navigation",
        "choices": [
          "To manage app navigation",
          "To manage app state",
          "To show dialogs",
          "To control themes"
        ],
      },
      {
        "question": "Which method is used to display a Snackbar in Flutter?",
        "correctAnswer": "ScaffoldMessenger.showSnackBar()",
        "choices": [
          "Scaffold.showSnackBar()",
          "ScaffoldMessenger.showSnackBar()",
          "Dialog.showSnackBar()",
          "SnackBar.show()"
        ],
      },
      {
        "question":
            "What is the name of the widget used to create a custom app bar in Flutter?",
        "correctAnswer": "AppBar",
        "choices": ["CustomAppBar", "AppBar", "Header", "NavigationBar"],
      },
      {
        "question":
            "Which package is used for working with shared preferences in Flutter?",
        "correctAnswer": "shared_preferences",
        "choices": ["hive", "shared_preferences", "sqflite", "path_provider"],
      },
      {
        "question": "What is the default value of a 'bool' variable in Dart?",
        "correctAnswer": "false",
        "choices": ["false", "true", "null", "0"],
      },
      {
        "question":
            "What is the name of the method used to change the app theme in Flutter?",
        "correctAnswer": "ThemeData",
        "choices": ["ThemeData", "ChangeTheme", "Theme", "AppTheme"],
      },
      {
        "question":
            "Which widget is used to make a widget take up available space in Flutter?",
        "correctAnswer": "Expanded",
        "choices": ["Expanded", "Flexible", "Align", "Container"],
      },
      {
        "question": "Which method is used to initialize an app in Flutter?",
        "correctAnswer": "main()",
        "choices": ["main()", "initialize()", "startApp()", "initApp()"],
      },
      {
        "question":
            "What is the name of the widget used to display an image in Flutter?",
        "correctAnswer": "Image",
        "choices": ["Picture", "Image", "AssetImage", "NetworkImage"],
      },
      {
        "question":
            "Which method is used to add a listener to a stream in Flutter?",
        "correctAnswer": "listen()",
        "choices": ["stream()", "addListener()", "subscribe()", "listen()"],
      },
      {
        "question": "Which widget is used to display a simple icon in Flutter?",
        "correctAnswer": "Icon",
        "choices": ["Icon", "IconButton", "RaisedButton", "FlatButton"],
      },
      {
        "question":
            "Which of the following widgets allows user input in Flutter?",
        "correctAnswer": "TextField",
        "choices": ["Text", "TextField", "Column", "Row"],
      },
      {
        "question":
            "What method is used to pop the current route from the navigator stack?",
        "correctAnswer": "Navigator.pop()",
        "choices": [
          "Navigator.pop()",
          "Navigator.push()",
          "Navigator.replace()",
          "Navigator.remove()"
        ],
      },
      {
        "question":
            "What is the purpose of the 'MaterialApp' widget in Flutter?",
        "correctAnswer": "To initialize the app with material design",
        "choices": [
          "To initialize the app with material design",
          "To define the routes",
          "To manage state",
          "To manage theme"
        ],
      },
      {
        "question":
            "What is the purpose of the 'MaterialApp' widget in Flutter?",
        "correctAnswer": "To initialize the app with material design",
        "choices": [
          "To initialize the app with material design",
          "To define the routes",
          "To manage state",
          "To manage theme"
        ]
      },
      {
        "question":
            "What widget is commonly used for layout and organizing widgets in a column format?",
        "correctAnswer": "Column",
        "choices": ["Column", "Row", "Stack", "ListView"]
      },
      {
        "question":
            "Which widget should be used for creating a scrollable list in Flutter?",
        "correctAnswer": "ListView",
        "choices": ["ListView", "Column", "Row", "ScrollView"]
      },
      {
        "question":
            "What widget is used to make parts of the screen scrollable?",
        "correctAnswer": "SingleChildScrollView",
        "choices": ["SingleChildScrollView", "Column", "Container", "Expanded"]
      },
    ];

    if (questionBox.isEmpty) {
      int questionId = 1;

      for (var qa in questionsWithChoices) {
        final questionText = qa["question"]!;
        final correctAnswer = qa["correctAnswer"]!;
        final choices = qa["choices"]! as List<String>;
        final correctAnswerIndex = choices.indexOf(correctAnswer);
        final question = Question(
            id: questionId,
            question: questionText,
            answerChoicesID: correctAnswerIndex);
        questionBox.put(questionId, question);

        for (int j = 0; j < choices.length; j++) {
          final choiceText = choices[j];
          final choiceID = questionId * 10 + j;
          final choice =
              Choice(id: choiceID, questionID: questionId, choice: choiceText);
          choiceBox.put(choiceID, choice);
        }

        questionId++;
      }
      print(
          "One-word dummy questions with answers added to Hive .${choiceBox.length}");
    } else {
      print(
          "Questions already exist in Hive. Skipping dummy data population.${choiceBox.length}");
    }
  }
}
