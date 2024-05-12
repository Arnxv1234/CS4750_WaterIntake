import 'package:flutter/material.dart';

void main() {
  runApp(WaterIntakeApp());
}

class WaterIntakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Intake Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WaterIntakeCalculator(),
    );
  }
}

class WaterIntakeCalculator extends StatefulWidget {
  const WaterIntakeCalculator({super.key});

  @override
  _WaterIntakeCalculatorState createState() => _WaterIntakeCalculatorState();
}

class _WaterIntakeCalculatorState extends State<WaterIntakeCalculator> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String gender = 'male';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Intake Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: gender,
              onChanged: (newValue) {
                setState(() {
                  gender = newValue!;
                });
              },
              items: <String>['male', 'female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your height';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your weight';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                calculateWaterIntake();
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 16.0),
            Text(
              result,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void calculateWaterIntake() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);

    double waterIntake = 0;
    if (gender == 'male') {
      waterIntake = calculateWaterForMale(weight);
    } else if (gender == 'female') {
      waterIntake = calculateWaterForFemale(weight);
    }

    setState(() {
      result = 'You need to drink approximately ${waterIntake.toStringAsFixed(2)} liters of water per day.';
    });
  }

  double calculateWaterForMale(double weight) {
    // Formula for male: 35 ml/kg/day
    return weight * 0.035 * 30;
  }

  double calculateWaterForFemale(double weight) {
    // Formula for female: 31 ml/kg/day
    return weight * 0.031 * 30;
  }
}


