import 'package:flutter/material.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({super.key});

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  List type = [
    'Credit',
    'Debit',
  ];

  int isselected = -1;

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Entry"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Name',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),

            SizedBox(
              height: s.height * 0.05,
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  // hintText: 'Enter Name',
                  labelText: 'Enter Name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                  labelStyle: TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Colors.deepPurple.shade500, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                ),
              ),
            ),
            // Text('Mobile Number',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
            SizedBox(
              height: s.height * 0.02,
            ),
            SizedBox(
              height: s.height * 0.05,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  // hintText: 'Enter Mobile Number',
                  labelText: 'Enter Mobile Number',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                  labelStyle: TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Colors.deepPurple.shade500, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: s.height * 0.02,
            ),
            SizedBox(
              height: s.height * 0.05,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  // hintText: 'Enter Amount',
                  labelText: 'Enter Amount',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                  labelStyle: TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Colors.deepPurple.shade500, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: s.height * 0.02,
            ),
            Row(
              children: List.generate(
                  type.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        if(isselected != index){
                          isselected = index;
                        }else{
                          isselected = -1;
                        }
                        // isselected = index;
                      });
                    },
                    child: Container(
                          height: s.height * 0.05,
                          width: s.width * 0.15,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: isselected == index ?  type[index] == 'Credit'
                                ? Colors.green.shade300
                                : Colors.red.shade300: Colors.white,
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
                                color: isselected == index ? Colors.white : Colors.black.withOpacity(0.5) ,
                                fontSize: 14),
                          ),
                        ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
