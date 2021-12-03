import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/common/notification_handler.dart';
import 'package:flutter_assignment/repository/image_repository.dart';
import 'package:flutter_assignment/state/app_state.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController? _controller = CarouselController();
  int currentPos = 0;

  @override
  void initState() {
    // TODO: implement initState
    var provider = Provider.of<AppState>(context, listen: false);
    provider.getImage(context);
    NotificationHandler().getNotification(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                        const SliverAppBar(
                          elevation: 1,
                          centerTitle: true,
                          backgroundColor: Colors.white38,
                          automaticallyImplyLeading: false,
                          pinned: true,
                          snap: true,
                          floating: true,
                          title: Text(
                            "Home Page",
                            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: size.height * 0.35,
                            child: Column(
                              children: [
                                CarouselSlider.builder(
                                  itemCount: provider.carouselList.length,
                                  options: CarouselOptions(
                                      autoPlay: true,
                                      viewportFraction: 0.9,
                                      pageSnapping: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          currentPos = index;
                                        });
                                      }),
                                  itemBuilder: (context, index, i) {
                                    return Container(
                                      // margin: EdgeInsets.symmetric(horizontal: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          provider.carouselList[index],

                                          height: size.height*0.3,
                                          width: size.width*0.8,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: provider.carouselList
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          _controller!.animateToPage(entry.key),
                                      child: Container(
                                        width: 12.0,
                                        height: 12.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                (Theme.of(context).brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors.black)
                                                    .withOpacity(
                                                        currentPos == entry.key
                                                            ? 0.9
                                                            : 0.4)),
                                      ),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text("Find out more.....",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),

                              child: Image.network(
                                "${provider.list[index]}",
                                height: size.height*0.3,
                                width: size.width*0.8,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        }, childCount: 20)),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
