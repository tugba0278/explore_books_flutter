import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Hello TabBar",
            style: TextStyle(
              fontSize: 30,
              color: Colors.red,
            ),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Tab(
                  icon: Icon(Icons.home),
                  text: "Home",
                ),
              ),
              Tab(
                child: ListView(
                  children: const [
                    Icon(Icons.home),
                    Icon(Icons.person),
                  ],
                ),
              ),
              const Tab(
                icon: Icon(Icons.account_circle),
                text: "Account",
              ),
              const Tab(
                icon: Icon(Icons.person),
                text: "Person",
              ),
              const Tab(
                icon: Icon(Icons.login_outlined),
                text: "Login",
              ),
              const Tab(
                icon: Icon(Icons.exit_to_app),
                text: "Exit",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(color: Colors.red),
            Container(color: Colors.green),
            Container(color: Colors.blue),
          ],
        ),
      ),
    ),
  ));
}
