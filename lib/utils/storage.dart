import 'dart:io';
import 'dart:convert';
import '../model/task.dart';
class TaskStorage{
  static final File _file=File('${Directory.systemTemp.path}/tasks.json');
  static Future<List<Task>> loadTasks() async {
    try
    {
      if(await _file.exists())
      {
        final jsonString =await _file.readAsString();
        if(jsonString.isNotEmpty)
        {
          return Task.decodeList(jsonString);
        }
      }
      return [];
    }
    catch(e)
    {
      print('Error in loading task file: $e');
      return [];
    }
  }
  static Future<void> savetask(List<Task> tasks) async
  {
    try
    {
      final jsonString = Task.encodeList(tasks);
      await _file.writeAsString(jsonString,flush: true);
      }
    catch(e)
    {
      print('Error saving task : $e');
    }
  }
  static Future<void> clear() async
  {
    try
    {
      if(await _file.exists())
      {
        await _file.delete();
      }
    }
    catch(e)
    {
      print('Error while reseting : $e');
    }
  }
}