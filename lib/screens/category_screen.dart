import 'package:db_miner2/helper/db_helper.dart';
import 'package:db_miner2/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Database? db;
  late Future<List> getAllData;
  late Future<List> totalCatData;

  @override
  void initState() {
    super.initState();
    totalCatData = DBHelper.dbHelper.fetchDataCount();
    getAllData = DBHelper.dbHelper.fetchCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade200,
      body: Container(
        padding: const EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Animal Biography",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Choose Category",
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: FutureBuilder(
                future: getAllData,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                      ),
                    );
                  } else if (snapshot.hasData) {
                    List data = snapshot.data;
                    // print(totalCatData);
                    // print(totalCatData.length);
                    // print(data);
                    // print(data.length);
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        // print(data[i].catId);
                        return InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            height: 165,
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(
                                  data[i].catImage,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      data[i].catName,
                                      maxLines: 2,
                                      softWrap: true,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.memory(
                                        data[i].catIcon,
                                        height: 70,
                                        width: 70,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      FutureBuilder(
                                        future: totalCatData,
                                        builder: (context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                'Error: ${snapshot.error}',
                                              ),
                                            );
                                          } else if (snapshot.hasData) {
                                            List catData = snapshot.data;
                                            // print(catData);
                                            return Text(
                                              "${catData[i]['COUNT(animal_id)']}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  id: data[i].catId,
                                  catData: data,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
