import '../model/task.dart';
import 'home_screen.dart';
import '../utils/storage.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState()=>_SplashScreenState();
  }
class _SplashScreenState extends State<SplashScreen>
{
  List<Task> _task=[];
  @override
  void initState(){
  _loadData();
}
Future<void> _loadData() async
{
  await Future.delayed(const Duration(seconds: 1));
  final loadedTasks = await TaskStorage.loadTasks();
  setState(() {
    _task=loadedTasks;
  });
  Navigator.pushReplacement(context, 
  MaterialPageRoute(
    builder: (context)=>HomeScreen(tasks: _task),
  ),);
}
@override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle,size: 64,color: Colors.blue,)
          ,const SizedBox(height:16),
          const Text('My To-Do App',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          const SizedBox(height: 20),
          const CircularProgressIndicator(),  
        ],
      ),
    ),
    );
  }
}