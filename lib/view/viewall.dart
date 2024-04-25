import 'package:flutter/material.dart';
import 'package:khata_book/controller/helper/sqliteHelper.dart';

class ViewAllTab extends StatefulWidget {
  @override
  _ViewAllTabState createState() => _ViewAllTabState();
}

class _ViewAllTabState extends State<ViewAllTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Records'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Credit'),
            Tab(text: 'Debit'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: FutureBuilder(
                future: SQLiteHelper.sqLiteHelper.getCreditdata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data as List;
                    return data.length == 0 ? Center(child: Text('No Data Found',style: TextStyle(fontSize: 18),),) :  ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: s.height * 0.08,
                          width: s.width,
                          margin: EdgeInsets.only(bottom: s.height * 0.02),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple.shade500),
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['name'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                        // color: Colors.black

                                        fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    data[index]['number'].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                        // color: Colors.black

                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                '₹ ' + data[index]['money'].toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: data[index]['type'] == 'Credit'
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    fontFamily: 'Poppins'),
                              ),
                              // SizedBox(
                              //   width: s.width * 0.01,
                              // ),
                              data[index]['type'] == 'Debit'
                                  ? PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.done_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Money Credited'),
                                        ],
                                      ),
                                      value: 'done',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.call_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Call'),
                                        ],
                                      ),
                                      value: 'call',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.chat_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Message'),
                                        ],
                                      ),
                                      value: 'masg',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete_outline_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Remove'),
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
                                      SQLiteHelper.sqLiteHelper.deletedata(
                                          data[index]['_id']);
                                      setState(() {

                                      });
                                      // Handle option 2 selection
                                      break;
                                    case 'done':
                                      SQLiteHelper.sqLiteHelper.updatedata(
                                          data[index]['_id'],
                                          data[index]['name'],
                                          data[index]['number'],
                                          data[index]['money'],
                                          'Credit');
                                      setState(() {

                                      });
                                      // Handle option 2 selection
                                      break;
                                  }
                                },
                              )
                                  : PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.call_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Call'),
                                        ],
                                      ),
                                      value: 'call',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.chat_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Message'),
                                        ],
                                      ),
                                      value: 'masg',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete_outline_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Remove'),
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
                                      SQLiteHelper.sqLiteHelper.deletedata(
                                          data[index]['_id']);
                                      setState(() {

                                      });
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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: FutureBuilder(
                future: SQLiteHelper.sqLiteHelper.getDeditdata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data as List;
                    return data.length == 0 ? Center(child: Text('No Data Found',style: TextStyle(fontSize: 18),),) : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: s.height * 0.08,
                          width: s.width,
                          margin: EdgeInsets.only(bottom: s.height * 0.02),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple.shade500),
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['name'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                        // color: Colors.black

                                        fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    data[index]['number'].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                        // color: Colors.black

                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                '₹ ' + data[index]['money'].toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: data[index]['type'] == 'Credit'
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    fontFamily: 'Poppins'),
                              ),
                              // SizedBox(
                              //   width: s.width * 0.01,
                              // ),
                              data[index]['type'] == 'Debit'
                                  ? PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.done_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Money Credited'),
                                        ],
                                      ),
                                      value: 'done',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.call_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Call'),
                                        ],
                                      ),
                                      value: 'call',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.chat_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Message'),
                                        ],
                                      ),
                                      value: 'masg',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete_outline_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Remove'),
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
                                      SQLiteHelper.sqLiteHelper.deletedata(
                                          data[index]['_id']);
                                      setState(() {

                                      });
                                      // Handle option 2 selection
                                      break;
                                    case 'done':
                                      SQLiteHelper.sqLiteHelper.updatedata(
                                          data[index]['_id'],
                                          data[index]['name'],
                                          data[index]['number'],
                                          data[index]['money'],
                                          'Credit');
                                      setState(() {

                                      });
                                      // Handle option 2 selection
                                      break;
                                  }
                                },
                              )
                                  : PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.call_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Call'),
                                        ],
                                      ),
                                      value: 'call',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.chat_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Message'),
                                        ],
                                      ),
                                      value: 'masg',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete_outline_outlined),
                                          SizedBox(
                                            width: s.width * 0.01,
                                          ),
                                          Text('Remove'),
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
                                      SQLiteHelper.sqLiteHelper.deletedata(
                                          data[index]['_id']);
                                      setState(() {

                                      });
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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}