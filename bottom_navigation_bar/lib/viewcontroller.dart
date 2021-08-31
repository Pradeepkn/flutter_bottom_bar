import 'package:bottom_navigation_bar/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'providers/user_provider.dart';
import 'tab_navigator.dart';
import 'package:provider/provider.dart';

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
              child: Consumer<UserProvider>(builder: (context, repo, _) {
                return Text(
                  repo.usercontainer.username,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                );
              }),
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
            child: Column(
              children: [
                Center(
                  child: Consumer<UserProvider>(
                    builder: (context, repo, _) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(repo.usercontainer.username),
                          SizedBox(
                            height: 50.0,
                          ),
                          TextField(
                            onChanged: (value) {
                              repo.changeValue(value);
                            },
                          ),
                        ],
                      ));
                    },
                  ),
                ),
                Consumer<UserProvider>(builder: (context, repo, _) {
                  return Container(child: Text(repo.usercontainer.username));
                })
              ],
            )));
  }
}
