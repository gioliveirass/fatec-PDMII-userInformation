import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avaliação',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Color textColor = Colors.black; 
  Color textColorWarning = Colors.grey;
  Color borderColor = Colors.grey;

  String _result = "";
  bool sent = false;

  void _send() {
    String login = _login.text;
    String password = _password.text;

    void changeTextColor(Color newColor) {
      setState(() {
        textColor = newColor;
      });
    }

    void changeBorderColor(Color newColor) {
      setState(() {
        borderColor = newColor;
      });
    }

    setState(() {
      if (login == "") {
        changeTextColor(Colors.red);
        changeBorderColor(Colors.red);
        _result = "Insira seu login";
      } else if (password == "") {
        changeTextColor(Colors.red);
        changeBorderColor(Colors.red);
        _result = "Insira sua senha";
      } else if (login != "teste") {
        changeTextColor(Colors.red);
        changeBorderColor(Colors.red);
        _result = "Acesso não permitido";
      } else if(password != "123") {
        changeTextColor(Colors.red);
        changeBorderColor(Colors.red);
        _result = "Acesso não permitido";
      } else {
        changeTextColor(Colors.black);
        changeBorderColor(Colors.black);
        _result = "";

        Navigator.push( context,
          MaterialPageRoute(builder: (context) => QuestionPage()),
        );
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16.0),
            Text(
              "Avaliação",
              style: TextStyle(fontSize: 24.0, color: textColor),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _login, 
                keyboardType: TextInputType.text, 
                decoration: InputDecoration(
                  hintText: 'Login',
                  prefixIcon: const Icon(Icons.account_circle_outlined), 
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor), 
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  )
                )
              )
            ),
            const SizedBox(height: 16.0), 
            SizedBox(
              width: 300,
              child: TextField(
                controller: _password, 
                keyboardType: TextInputType.text, 
                decoration: InputDecoration(
                  hintText: 'Senha',
                  prefixIcon: const Icon(Icons.account_circle_outlined), 
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor), 
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  )
                )
              )
            ),
            const SizedBox(height: 16.0), 
            !sent
             ? SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _send,
                    child: const Text('Enviar'),
                  ),
                ]
              ),
             ) 
             : const SizedBox.shrink(),
            const SizedBox(height: 16.0),
            Text(
              _result,
              style: TextStyle(fontSize: 24.0, color: textColor),
            ),
          ]
        ),
      )
    );
  }
}

class QuestionPage extends StatefulWidget {
  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  Color textColor = Colors.black; 
  Color textColorWarning = Colors.grey;
  Color borderColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16.0),
            Text(
              "Avaliação",
              style: TextStyle(fontSize: 24.0, color: textColor),
            ),
            const SizedBox(height: 16.0),
            CheckboxSample(
              checked: {
                'Flutter': false,
                'React Native': false,
                'Kotlin': false,
                'Java': false,
                'Ionic': false,
              },
              question: "Quais tecnologias mobile conhece?",
            ),
          ]
        ),
      )
    );
  }
}

class CheckboxSample extends StatefulWidget {
  final Map<String, bool> checked;
  final String question;

  const CheckboxSample(
    {
      Key? key, 
      required this.checked, 
      required this.question,
    }
  ) : super(key: key);

  @override
  CheckboxSampleState createState() => CheckboxSampleState(
    checked: checked, 
    question: question
  );
}

class CheckboxSampleState extends State<CheckboxSample> {
  final Map<String, bool> checked;
  final String question;

  CheckboxSampleState({required this.checked, required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildCheckboxes(),
        ),
    );
  }

  List<Widget> _buildCheckboxes() {
    List<Widget> checkboxes = [];

    checkboxes.add(
      Text(
        question,
        style: TextStyle(fontSize: 24.0, color: Colors.blue),
      ),
    );

    checkboxes.add(SizedBox(height: 16.0));

    checked.forEach((String key, bool value) {
      checkboxes.add(
        CheckboxListTile(
          title: Text(key),
          value: value,

          onChanged: ( newValue) {
            setState(() {
              newValue != null
                ? checked[key] == true
                  ? checked[key] = false
                  : checked[key] = true
                : checked[key] = false;  
            });
          },
        ),
      );
    });

    checkboxes.add(SizedBox(height: 16.0));

    checkboxes.add(
      Align(
        alignment: Alignment.topCenter,
        child: ElevatedButton(
          onPressed: () {
            _showSelected();
          },
          child: const Text('Enviar'),
        )
      ),
    );
    
    return checkboxes;
  }

  void _showSelected() {
    List<String> selected = [];

    checked.forEach((String key, bool value) {
      if (value) { // se valor válido
        selected.add(key);
      }
    });

    Navigator.push( context,
      MaterialPageRoute(builder: (context) => QuestionResultPage(selectedTechs: selected)),
    );
  }
}

class QuestionResultPage extends StatefulWidget {
  final List<String> selectedTechs; 

  const QuestionResultPage(
    {
      Key? key, 
      required this.selectedTechs, 
    }
  ) : super(key: key);

  @override
  QuestionResultPageState createState() => QuestionResultPageState(selectedTechs: selectedTechs);
}

class QuestionResultPageState extends State<QuestionResultPage> {
  final List<String> selectedTechs; 

  QuestionResultPageState({required this.selectedTechs});

  Color textColor = Colors.black; 
  Color textColorWarning = Colors.grey;
  Color borderColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
           children: [
            const Divider(),
            const SizedBox(height: 16.0),
            Text(
              "Avaliação",
              style: TextStyle(fontSize: 24.0, color: textColor),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: selectedTechs.length,
                 itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(selectedTechs[index]),
                  );
                 }
              )
            ),
            const SizedBox(height: 16.0),
             const Text(
              'Informações enviadas ao servidor...',
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
            ),
           ]
        )
      )
    );
  }
}