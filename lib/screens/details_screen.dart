import 'package:db_miner2/helper/db_helper.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final List? catData;
  final int? id;

  const DetailsScreen({this.catData, this.id, Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<List> fetchAnimalData;
  int? id;

  @override
  void initState() {
    super.initState();
    fetchAnimalData = DBHelper.dbHelper.fetchAnimalData();
    id = widget.id;
    // print(id);
    // print(widget.catData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchAnimalData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          } else if (snapshot.hasData) {
            List animalData = snapshot.data;
            // print(animalData);
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(
                        widget.catData![id! - 1].catImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 170,
                      child: Text(
                        widget.catData![id! - 1].catName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 22,
                      right: 15,
                      bottom: 15,
                    ),
                    height: MediaQuery.of(context).size.height * 0.68,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.brown.shade300,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Related for you",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: animalData.map(
                                (e) {
                                  if (e.catId == id) {
                                    return Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height *
                                                  0.40,
                                              width: MediaQuery.of(context).size.width *
                                                  0.52,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(26),
                                                image: DecorationImage(
                                                  image: MemoryImage(
                                                    e.animalImage,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              e.animalName,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width *
                                                  0.52,
                                              child: Text(
                                                e.animalDetails,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 22,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Quick categories",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.catData!.map(
                                (e) {
                                  return Row(
                                    children: [
                                      InkWell(
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(20),
                                              height: MediaQuery.of(context).size.height *
                                                  0.18,
                                              width: MediaQuery.of(context).size.width *
                                                  0.38,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(26),
                                                color: Colors.brown.shade200,
                                              ),
                                              child: Image.memory(e.catIcon),
                                            ),
                                            const SizedBox(
                                              height: 22,
                                            ),
                                            Text(
                                              e.catName
                                                  .toString()
                                                  .toUpperCase()
                                                  .split(' ')[0],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            id = e.catId;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 26,
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
