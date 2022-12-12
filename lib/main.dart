import 'dart:developer';
import 'dart:io';

import 'package:cache_manager_dio_test/provider/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'flutter_cache_manager_dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) {
            return UserProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Cache'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String filePath =
      '/data/user/0/com.example.cache_manager_dio_test/cache/dioCache/aad93e60-7997-11ed-8e60-c1045e488e3b.json';

  Future<File> get _localFile async {
    return File(filePath);
  }

  void _incrementCounter() async {
    // String url = 'https://jsonplaceholder.typicode.com/users';
    // var file = await DioCacheManager.instance.getSingleFile(url);

    // FileServiceResponse xd = await DioHttpFileService(dio).get(url);

    // print('Valid till 😂😂😂 ${xd.validTill}');

    // print('\n 🛣️🛣️🛣️🛣️' + file.path);
    // final contents = await file.readAsString();
    // print('🗃️🗃️🗃️ $contents');
    // final file = await _localFile;
    // final contents = await file.readAsString();

    // log('read from ✅ $contents');

    // // print(file.rename('KLK'));
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            userProvider.fetchUsers();
          },
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: userProvider.readUsers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(userProvider.readUsers[index].name!),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        // onPressed: ()async {
        //   print(await _localPath);
        // },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
