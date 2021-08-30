import 'package:flutter/material.dart';
import 'tab_navigator.dart';

class ViewController extends StatefulWidget {
  final String title;
  final ValueChanged<String> onPush;

  const ViewController({Key? key, required this.title, required this.onPush})
      : super(key: key);

  @override
  _ViewControllerState createState() => _ViewControllerState();
}

class _ViewControllerState extends State<ViewController> {
  @override
  void initState() {
    print('View Controller launched');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.title == tabName[TabItem.home]
              ? Colors.blueGrey
              : widget.title == tabName[TabItem.search]
                  ? Colors.blueGrey
                  : Colors.blueGrey,
          title: Text(
            '${widget.title}',
          ),
        ),
        body: Container(
          child: Center(
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                widget.onPush(widget.title);
              },
              child: Text(
                'Click Here',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
          color: widget.title == tabName[TabItem.home]
              ? Colors.black12
              : widget.title == tabName[TabItem.search]
                  ? Colors.black26
                  : Colors.black38,
        ));
  }
}

class ControllerDetailPage extends StatelessWidget {
  ControllerDetailPage({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(
            '$title',
          ),
        ),
        body: Container(
            color: this.title == tabName[TabItem.home]
                ? Colors.black12
                : this.title == tabName[TabItem.search]
                    ? Colors.black26
                    : Colors.black38,
            child: Center(
              child: Text(
                '$title',
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontSize: 30),
              ),
            )));
  }
}
