import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _counter = 0;
  bool _isPlaying = false;
  String _inputText = '';

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playBeep() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() => _isPlaying = false);
    } else {
      await _audioPlayer.play(UrlSource(
          'https://www.soundjay.com/buttons/sounds/button-09a.mp3'));
      setState(() => _isPlaying = true);

      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() => _isPlaying = false);
      });
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Popup Dialog'),
          content: const Text('This is a popup with explicit positioning demo!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo - Explicit Positioning'),
      ),
      body: Stack(
        children: [
          // LABEL 1: Title Text
          // x: 20, y: 20, w: 400, h: 40
          Positioned(
            left: 20,
            top: 20,
            width: 400,
            height: 40,
            child: Container(
              color: Colors.blue.shade100,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Label 1: Main Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // LABEL 2: Counter Display
          // x: 20, y: 80, w: 200, h: 80
          Positioned(
            left: 20,
            top: 80,
            width: 200,
            height: 80,
            child: Container(
              color: Colors.green.shade100,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Label 2: Counter',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '$_counter',
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // BUTTON 1: Increment
          // x: 240, y: 80, w: 150, h: 35
          Positioned(
            left: 240,
            top: 80,
            width: 150,
            height: 35,
            child: ElevatedButton(
              onPressed: () => setState(() => _counter++),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Button 1: +1'),
            ),
          ),

          // BUTTON 2: Reset
          // x: 240, y: 125, w: 150, h: 35
          Positioned(
            left: 240,
            top: 125,
            width: 150,
            height: 35,
            child: ElevatedButton(
              onPressed: () => setState(() => _counter = 0),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Button 2: Reset'),
            ),
          ),

          // LABEL 3: Audio Status
          // x: 20, y: 180, w: 200, h: 60
          Positioned(
            left: 20,
            top: 180,
            width: 200,
            height: 60,
            child: Container(
              color: Colors.orange.shade100,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Label 3: Audio',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    _isPlaying ? 'Playing...' : 'Stopped',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // BUTTON 3: Play/Stop Audio
          // x: 240, y: 180, w: 150, h: 60
          Positioned(
            left: 240,
            top: 180,
            width: 150,
            height: 60,
            child: ElevatedButton(
              onPressed: _playBeep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                  Text(_isPlaying ? 'Button 3: Stop' : 'Button 3: Play'),
                ],
              ),
            ),
          ),

          // LABEL 4: Text Input
          // x: 20, y: 260, w: 370, h: 60
          Positioned(
            left: 20,
            top: 260,
            width: 370,
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Label 4: Text Input',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 35,
                  child: TextField(
                    onChanged: (value) => setState(() => _inputText = value),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type here...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // LABEL 5: Input Display
          // x: 20, y: 330, w: 370, h: 40
          Positioned(
            left: 20,
            top: 330,
            width: 370,
            height: 40,
            child: Container(
              color: Colors.purple.shade100,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8),
              child: Text(
                'Label 5: You typed: $_inputText',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),

          // BUTTON 4: Show Popup Dialog
          // x: 20, y: 390, w: 180, h: 50
          Positioned(
            left: 20,
            top: 390,
            width: 180,
            height: 50,
            child: ElevatedButton(
              onPressed: _showDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Button 4: Show Popup'),
            ),
          ),

          // LABEL 6: Status Text
          // x: 210, y: 390, w: 180, h: 50
          Positioned(
            left: 210,
            top: 390,
            width: 180,
            height: 50,
            child: Container(
              color: Colors.yellow.shade200,
              alignment: Alignment.center,
              child: const Text(
                'Label 6: Status OK',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // LABEL 7: Info Box
          // x: 20, y: 460, w: 370, h: 80
          Positioned(
            left: 20,
            top: 460,
            width: 370,
            height: 80,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.cyan.shade100,
                border: Border.all(color: Colors.cyan.shade700, width: 2),
              ),
              padding: const EdgeInsets.all(8),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Label 7: Information Box',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'All UI elements have explicit x, y, width, and height values defined in the code.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          // BUTTON 5: Another Action
          // x: 420, y: 20, w: 160, h: 45
          Positioned(
            left: 420,
            top: 20,
            width: 160,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Button 5 clicked!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Button 5: Click Me'),
            ),
          ),

          // LABEL 8: Checkbox Section
          // x: 420, y: 80, w: 160, h: 80
          Positioned(
            left: 420,
            top: 80,
            width: 160,
            height: 80,
            child: Container(
              color: Colors.pink.shade100,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Label 8: Options',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                      const Text('Option A', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // LABEL 9: Progress Indicator
          // x: 420, y: 180, w: 160, h: 60
          Positioned(
            left: 420,
            top: 180,
            width: 160,
            height: 60,
            child: Container(
              color: Colors.amber.shade100,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Text(
                    'Label 9: Progress',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: _counter / 20,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ],
              ),
            ),
          ),

          // LABEL 10: Footer
          // x: 20, y: 560, w: 560, h: 30
          Positioned(
            left: 20,
            top: 560,
            width: 560,
            height: 30,
            child: Container(
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Text(
                'Label 10: Footer - All elements positioned with x, y, width, height',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}