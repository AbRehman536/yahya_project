import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/widgets/custom_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Carousel Slider
  List<String> imageList = [
    AppAssets.carousel3Image,
    AppAssets.carousel3Image,
    AppAssets.carousel3Image
  ];
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(AppAssets.carrotImage),
          Row(
            children: [
              Icon(Icons.add_location_rounded),
              Text("Rawalpindi, Pakistan")
            ],
          ),
          TextField(
            decoration: InputDecoration(
                fillColor: Color(0xffF2F3F2),
                filled: true,
                hint: Text("Search Store"),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: .circular(15),
                    borderSide: .none
                )
            ),
          ),
          CarouselSlider(
              items: imageList.map((images){
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: .circular(15),
                    image: DecorationImage(
                        image: NetworkImage(images),
                    fit: BoxFit.cover)
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: 200,
                viewportFraction: 0.8,
                autoPlay: true,
                onPageChanged: (index, reason){
                  setState(() {
                    selectedImage = index;
                  });
                }
              )),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomGrid(
                          image: AppAssets.cart1Image,
                          title: "Bell Peper Red",
                          description: "1Kg",
                          price: 4.99),
                    );
              },),
          )
        ],
      ),
    );
  }
}
