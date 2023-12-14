import 'package:api_train/model/test_api_model.dart';
import 'package:api_train/services/api_helper.dart';
import 'package:api_train/views/user_details_screen.dart';
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: controller,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height - 320,
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: namesList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserDetailsScreen(
                                testApiModel: testApiModel!,
                                index: index,
                              ),
                            ),
                          );
                        },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        child: Text(
                                            returnVowelCount(namesList[index])
                                                .toString()),
                                      ),
                                      Image.asset(
                                          returnVowelCount(namesList[index])
                                                  .isEven
                                              ? "assets/even.png"
                                              : "assets/odd.png")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  sortAscending();
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text("sort ascending"),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  sortDescending();
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text("sort descending"),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  hitTestApi(controller.text.isEmpty ? "5" : controller.text);
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text("submit"),
                  ),
                ),
              ),
              Text("the total names count : ${namesList.length}"),
            ],
          ),
        ),
      ),
    );
  }

  hitTestApi(String resultCount) async {
    testApiModel = await ApiBaseHelper().getTestApiResultMultiple(resultCount);
    // namesList.clear();
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
    List vowels = ['a', 'e', 'i', 'o', 'u'];

    // while()

    // for(int i = 0 ; i< vowels.length ; i++){
    //   Iterable matches = value.allMatches(vowels[i]);
    //   print("---------->>>>>>>>>>>${matches[i]}");
    //   // if(){
    //   //   vowelCount++;
    //   // }
    // }
    // return vowelCount;

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

class Sorting {
  List<int> testList = [2, 1, 4, 3, 5];
  void sortAscending() {
    testList.sort((a, b) => a.compareTo(b));
  }
}
