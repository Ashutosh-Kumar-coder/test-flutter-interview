import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_assignment/state/app_state.dart';
import 'package:flutter_assignment/ui/auth_page.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPos = 0;

  @override
  void initState() {
    // TODO: implement initState
    var provider = Provider.of<AppState>(context, listen: false);
    provider.getImage(context);

    super.initState();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_sharp),
            label: 'Appointment',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Account',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      backgroundColor: Colors.white,
      body: Consumer<AppState>(
        builder: (context, provider, child) {
          return SafeArea(
            child: provider.isLoading
                ? Container(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox(
                    height: size.height,
                    width: size.width,
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          elevation: 1,
                          backgroundColor: Colors.white38,
                          automaticallyImplyLeading: false,
                          pinned: false,
                          snap: true,
                          floating: true,
                          actions: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white, elevation: 0.0),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) => AuthPage()));
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.logout,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      "Logout",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ))
                          ],
                          title: const Text(
                            "Planet Web",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "Book Appointment",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: GridTile(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    "${provider.list[index].image}",
                                    fit: BoxFit.fill,
                                    // height: size.height * 0.08,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Text('Your error widget...');
                                    },
                                  ),
                                ),
                                footer: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.5)
                                        ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topRight)),
                                    alignment: Alignment.bottomRight,
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "${provider.list[index].name}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )),
                              ),
                            );
                          }, childCount: provider.list.length),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.3,
                            // crossAxisSpacing: 10,
                            // mainAxisSpacing: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
