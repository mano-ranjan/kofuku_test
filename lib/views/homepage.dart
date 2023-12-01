import 'package:api_train/model/test_api_model.dart';
import 'package:api_train/services/api_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TestApiModel? testApiModel;
  List<String> namesList = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height - 300,
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: namesList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(namesList[index].isEmpty
                                      ? "hi"
                                      : namesList[index]),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 10),
                                //   child: Text(testApiModel!
                                //       .results![index].name!.last!),
                                // ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(returnVowelCount(namesList[index])
                                          .toString()),
                                    ),
                                    Image.asset(
                                        returnVowelCount(namesList[index]).isEven
                                            ? "assets/even.png"
                                            : "assets/odd.png")
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: controller,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  sortAscending();
                },
                child: const SizedBox(
                  height: 50,
                  child: Text("sort ascending"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  sortDescending();
                },
                child: const SizedBox(
                  height: 50,
                  child: Text("sort descending"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  hitTestApi(controller.text.isEmpty ? "5" : controller.text);
                },
                child: const SizedBox(
                  height: 50,
                  child: Text("submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  hitTestApi(String resultCount) async {
    testApiModel = await ApiBaseHelper().getTestApiResultMultiple(resultCount);
    namesList.clear();
    for (int i = 0; i < testApiModel!.results!.length; i++) {
      namesList.add(
          "${testApiModel!.results![i].name!.first!} ${testApiModel!.results![i].name!.last!}");
    }
    setState(() {});
  }

  void sortAscending() {
    setState(() {
      namesList
          .sort((a, b) => returnVowelCount(a).compareTo(returnVowelCount(b)));
    });
  }

  void sortDescending() {
    setState(() {
      namesList
          .sort((b, a) => returnVowelCount(a).compareTo(returnVowelCount(b)));
    });
  }

  int returnVowelCount(String value) {
    value = value.toLowerCase();
    int vowelCount = 0;
    for (int i = 0; i < value.length; i++) {
      if (value[i] == 'a' ||
          value[i] == 'e' ||
          value[i] == 'i' ||
          value[i] == 'o' ||
          value[i] == 'u') {
        //Increments the vowel counter
        vowelCount++;
      }
    }
    return vowelCount;
    // return value.length;
  }
}
