import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator ',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18.0, color: Colors.black),
          headline1: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
      ),
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _selectedSex = 'Male';
  double _bmi = 0;
  String _bmiCategory = '';

  void _calculateBMI() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final int age = int.tryParse(_ageController.text) ?? 0;

    if (height > 0 && weight > 0 && age > 0) {
      setState(() {
        _bmi = weight / (height * height);

        if (_bmi < 18.5) {
          _bmiCategory = 'Underweight';
        } else if (_bmi >= 18.5 && _bmi < 24.9) {
          _bmiCategory = 'Normal weight';
        } else if (_bmi >= 25 && _bmi < 29.9) {
          _bmiCategory = 'Overweight';
        } else {
          _bmiCategory = 'Obese';
        }

        // Adjust interpretation based on age and sex
        if (_selectedSex == 'Male') {
          if (age < 20) {
            // Specific category adjustments for males under 20
            if (_bmi < 18.5) {
              _bmiCategory = 'Underweight (Youth)';
            } else if (_bmi >= 18.5 && _bmi < 25) {
              _bmiCategory = 'Healthy Weight (Youth)';
            } else {
              _bmiCategory = 'Overweight (Youth)';
            }
          }
        } else {
          if (age < 20) {
            // Specific category adjustments for females under 20
            if (_bmi < 18.5) {
              _bmiCategory = 'Underweight (Youth)';
            } else if (_bmi >= 18.5 && _bmi < 24) {
              _bmiCategory = 'Healthy Weight (Youth)';
            } else {
              _bmiCategory = 'Overweight (Youth)';
            }
          }
        }
      });
    } else {
      setState(() {
        _bmi = 0;
        _bmiCategory = 'Invalid input';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Calculate Your BMI',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (m eg 1.83)',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg )',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedSex,
                decoration: InputDecoration(
                  labelText: 'Sex',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                items: ['Male', 'Female']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSex = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBMI,
                child: Text('Calculate BMI'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              if (_bmi > 0)
                Column(
                  children: [
                    Text(
                      'Your BMI is: ${_bmi.toStringAsFixed(1)} \ by Natuel',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Category: $_bmiCategory',
                      style: TextStyle(fontSize: 20.0, color: Colors.teal[700]),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
