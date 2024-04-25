import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khata_book/controller/helper/sqliteHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List type = [
    'Credit',
    'Debit',
  ];

  int isselected = -1;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Khatabook',
          style: GoogleFonts.roboto(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.changeTheme(
                    Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              },
              icon: const Icon(Icons.sunny))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: s.height * 0.10,
                  width: s.width * 0.42,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.green.shade300),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.green.shade600.withOpacity(0.5),
                    //     spreadRadius: 5,
                    //     blurRadius: 7,
                    //     offset:
                    //         const Offset(0, 3), // changes position of shadow
                    //   ),
                    // ]
                  ),
                  alignment: Alignment.center,
                  child: FutureBuilder(
                      future: SQLiteHelper.sqLiteHelper.gettotalcredit(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int data = snapshot.data as int;
                          return Text(
                            'Credit : ₹ ${data.toString()}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent,
                                fontFamily: 'Poppins'),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
                const Spacer(),
                Container(
                  height: s.height * 0.10,
                  width: s.width * 0.42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.red.shade300),
                  ),
                  alignment: Alignment.center,
                  child: FutureBuilder(
                      future: SQLiteHelper.sqLiteHelper.gettotalDebit(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int data = snapshot.data as int;
                          return Text(
                            'Debit : ₹ ${data.toString()}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontFamily: 'Poppins'),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
              ],
            ),
            SizedBox(
              height: s.height * 0.05,
            ),
            Row(
              children: [
                const Center(
                  child: Text(
                    'Your Records',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // color: Colors.black,
                        fontFamily: 'Poppins'),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/viewAllTab');
                  },
                  child: const Text(
                    'View all',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: s.height * 0.05,
            ),
            Expanded(
              child: FutureBuilder(
                  future: SQLiteHelper.sqLiteHelper.getdata(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List data = snapshot.data as List;
                      return data.length == 0
                          ? const Center(
                              child: Text(
                                'No Data Found',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: s.height * 0.08,
                                  width: s.width,
                                  margin:
                                      EdgeInsets.only(bottom: s.height * 0.02),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.deepPurple.shade500),
                                      borderRadius: BorderRadius.circular(15)),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]['name'],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                // fontWeight: FontWeight.bold,
                                                // color: Colors.black

                                                fontFamily: 'Poppins'),
                                          ),
                                          Text(
                                            data[index]['number'].toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                // fontWeight: FontWeight.bold,
                                                // color: Colors.black

                                                fontFamily: 'Poppins'),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        '₹ ' + data[index]['money'].toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                data[index]['type'] == 'Credit'
                                                    ? Colors.greenAccent
                                                    : Colors.redAccent,
                                            fontFamily: 'Poppins'),
                                      ),
                                      // SizedBox(
                                      //   width: s.width * 0.01,
                                      // ),
                                      data[index]['type'] == 'Debit'
                                          ? PopupMenuButton(
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return [
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons
                                                            .done_outlined),
                                                        SizedBox(
                                                          width: s.width * 0.01,
                                                        ),
                                                        const Text(
                                                            'Money Credited'),
                                                      ],
                                                    ),
                                                    value: 'done',
                                                  ),
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons
                                                            .call_outlined),
                                                        SizedBox(
                                                          width: s.width * 0.01,
                                                        ),
                                                        const Text('Call'),
                                                      ],
                                                    ),
                                                    value: 'call',
                                                  ),
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons
                                                            .chat_outlined),
                                                        SizedBox(
                                                          width: s.width * 0.01,
                                                        ),
                                                        const Text('Message'),
                                                      ],
                                                    ),
                                                    value: 'masg',
                                                  ),
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons
                                                            .delete_outline_outlined),
                                                        SizedBox(
                                                          width: s.width * 0.01,
                                                        ),
                                                        const Text('Remove'),
                                                      ],
                                                    ),
                                                    value: 'remove',
                                                  ),
                                                ];
                                              },
                                              onSelected: (value) {
                                                switch (value) {
                                                  case 'call':
                                                    // Handle option 1 selection
                                                    break;
                                                  case 'masg':
                                                    // Handle option 2 selection
                                                    break;
                                                  case 'remove':
                                                    SQLiteHelper.sqLiteHelper
                                                        .deletedata(
                                                            data[index]['_id']);
                                                    setState(() {});
                                                    // Handle option 2 selection
                                                    break;
                                                  case 'done':
                                                    SQLiteHelper.sqLiteHelper
                                                        .updatedata(
                                                            data[index]['_id'],
                                                            data[index]['name'],
                                                            data[index]
                                                                ['number'],
                                                            data[index]
                                                                ['money'],
                                                            'Credit');
                                                    setState(() {});
                                                    // Handle option 2 selection
                                                    break;
                                                }
                                              },
                                            )
                                          : PopupMenuButton(
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return [
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons
                                                            .call_outlined),
                                                        SizedBox(
                                                          width: s.width * 0.01,
                                                        ),
                                                        const Text('Call'),
                                                      ],
                                                    ),
                                                    value: 'call',
                                                  ),
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons
                                                            .chat_outlined),
                                                        SizedBox(
                                                          width: s.width * 0.01,
                                                        ),
                                                        const Text('Message'),
                                                      ],
                                                    ),
                                                    value: 'masg',
                                                  ),
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons
                                                            .delete_outline_outlined),
                                                        SizedBox(
                                                          width: s.width * 0.01,
                                                        ),
                                                        const Text('Remove'),
                                                      ],
                                                    ),
                                                    value: 'remove',
                                                  ),
                                                ];
                                              },
                                              onSelected: (value) {
                                                switch (value) {
                                                  case 'call':
                                                    // Handle option 1 selection
                                                    break;
                                                  case 'remove':
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xff0F0F0F),
                                                                title:
                                                                    const Text(
                                                                  "Are You sure want to delete ?",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                actions: [
                                                                  ElevatedButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all(Colors.red),
                                                                        fixedSize:
                                                                            MaterialStateProperty.all(
                                                                          const Size(
                                                                              100,
                                                                              50),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                  ElevatedButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all(Colors.green),
                                                                        fixedSize:
                                                                            MaterialStateProperty.all(
                                                                          const Size(
                                                                              100,
                                                                              50),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        SQLiteHelper
                                                                            .sqLiteHelper
                                                                            .deletedata(data[index]['_id']);
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .done,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                ]));
                                                    // Handle option 2 selection
                                                    break;
                                                  case 'masg':
                                                    // Handle option 2 selection
                                                    break;
                                                }
                                              },
                                            ),
                                    ],
                                  ),
                                );
                              },
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ),
      ),
      // bottomSheet: GestureDetector(
      //   onTap: () {
      //     // Get.toNamed('/add');
      //   },
      //   child: Container(
      //     decoration: BoxDecoration(
      //       color: Colors.deepPurple.shade500,
      //       borderRadius: const BorderRadius.only(
      //         topLeft: Radius.circular(20),
      //         topRight: Radius.circular(20),
      //       ),
      //     ),
      //     height: s.height * 0.08,
      //     width: s.width,
      //     child: Center(
      //       child: Text(
      //         'Add Records'.toUpperCase(),
      //         style: const TextStyle(
      //           fontSize: 18,
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //           fontFamily: 'Poppins',
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade500,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => StatefulBuilder(builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 18,
                    right: 18),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      const Center(
                          child: Text(
                        'Add Record',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )),
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      SizedBox(
                        height: s.height * 0.08,
                        child: TextFormField(
                          controller: name,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            // color: Colors.black,
                            fontSize: 12,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Name';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            // hintText: 'Enter Name',
                            labelText: 'Enter Name',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                            labelStyle: const TextStyle(fontSize: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Colors.deepPurple.shade500,
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                      // Text('Mobile Number',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                      SizedBox(height: s.height * 0.01),
                      SizedBox(
                        height: s.height * 0.08,
                        child: TextFormField(
                          controller: mobile,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          style: const TextStyle(fontSize: 12),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Mobile Number';
                            } else if (value.length < 10 &&
                                value.length == 10) {
                              return 'Please enter valid Mobile Number';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            // hintText: 'Enter Mobile Number',
                            labelText: 'Enter Mobile Number',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                            labelStyle: const TextStyle(fontSize: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Colors.deepPurple.shade500,
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      SizedBox(
                        height: s.height * 0.08,
                        child: TextFormField(
                          controller: amount,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            // color: Colors.black,
                            fontSize: 12,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Amount';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            // hintText: 'Enter Amount',
                            labelText: 'Enter Amount',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                            labelStyle: const TextStyle(fontSize: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Colors.deepPurple.shade500,
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: s.height * 0.01),
                      Row(
                        children: List.generate(
                            type.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isselected != index) {
                                        isselected = index;
                                      } else {
                                        isselected = -1;
                                      }
                                      // isselected = index;
                                    });
                                  },
                                  child: Container(
                                    height: s.height * 0.05,
                                    width: s.width * 0.15,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: isselected == index
                                          ? type[index] == 'Credit'
                                              ? Colors.green.shade300
                                              : Colors.red.shade300
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: type[index] == 'Credit'
                                              ? Colors.green.shade300
                                              : Colors.red.shade300),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: type[index] == 'Credit'
                                      //         ? Colors.green.shade600.withOpacity(0.5)
                                      //         : Colors.red.shade600.withOpacity(0.5),
                                      //     spreadRadius: 5,
                                      //     blurRadius: 7,
                                      //     offset: const Offset(
                                      //         0, 3), // changes position of shadow
                                      //   ),
                                      // ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      type[index],
                                      style: TextStyle(
                                          // fontWeight: FontWeight.w500,
                                          color: isselected == index
                                              ? Colors.white
                                              : Colors.black.withOpacity(0.5),
                                          fontSize: 14),
                                    ),
                                  ),
                                )),
                      ),
                      SizedBox(height: s.height * 0.03),
                      GestureDetector(
                        onTap: () async {
                          if (formkey.currentState!.validate() &&
                              isselected != -1) {
                            log(amount.text);
                            await SQLiteHelper.sqLiteHelper.adddata(
                                name.text,
                                int.parse(mobile.text),
                                int.parse(amount.text),
                                type[isselected]);
                            var list =
                                await SQLiteHelper.sqLiteHelper.getdata();
                            log(list.toString());
                            setState(() {
                              name.clear();
                              mobile.clear();
                              amount.clear();
                              isselected = -1;
                              // listdata = list;
                            });
                            Navigator.pop(context);
                            Get.snackbar('Success', 'Data saved successfully',
                                colorText: Colors.white,
                                backgroundColor: Colors.green);
                          } else {
                            Get.snackbar(
                                'Error!!', 'Please fill all the details',
                                colorText: Colors.white,
                                backgroundColor: Colors.red);
                          }
                        },
                        child: Container(
                          height: s.height * 0.05,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade500,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Save'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.05,
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
