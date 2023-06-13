import 'package:flutter/material.dart';

class MainTestScreen extends StatefulWidget {
  const MainTestScreen({super.key});

  @override
  State<MainTestScreen> createState() => _MainTestScreenState();
}

class _MainTestScreenState extends State<MainTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          shadowColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: ElevatedButton(onPressed: () {

            },child: Text('dsgsdg')),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [ElevatedButton(onPressed: () {

              }, child: Text  ('dgds'))],
            ),
          ),
        ),
      ),
      body: Container(color:Colors.red ,),
    );
  }
}
