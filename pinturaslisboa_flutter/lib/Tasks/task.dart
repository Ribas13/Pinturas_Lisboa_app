
import 'dart:math';

import 'package:hive_flutter/adapters.dart';

import '../job.dart';
/* 
  Task(jobname, tasktype(sanding, primer, etc), index, completed)
*/

class Task {
  String title = "";
  String key = "";
  String type = "";
  int index = 0;
  bool completed = false;

  Task(String title, String key, String type, int index, bool completed) {
    this.title = title;
    this.key = key;
    this.type = type;
    this.index = index;
    this.completed = completed;
  }
}

class Tasks {
  //db
  var tasks_db;
  List<Task>? task_list = null;

  //constructor should create entries in the task list for every type of task
  Tasks(Job job) {
    //init db instance
    int maxRooms = max(job.rooms, max(job.bathrooms, max(job.kitchens, max(job.livingRooms, max(job.hallways, max(job.balconies, max(job.garages, job.otherRooms)))))));
    print("maxRooms: $maxRooms");
    for (int i = 0; i < maxRooms; i++) {
      //create a each task type for each room
      if (i < job.rooms) {
          task_list!.add(Task("Room ${i + 1}", job.title, "covering", i, false));
          task_list!.add(Task("Room ${i + 1}", job.title, "filler", i, false));
          task_list!.add(Task("Room ${i + 1}", job.title, "sanding", i, false));
          task_list!.add(Task("Room ${i + 1}", job.title, "primer", i, false));
          task_list!.add(Task("Room ${i + 1}", job.title, "first_coat", i, false));
          task_list!.add(Task("Room ${i + 1}", job.title, "final_coat", i, false));
          task_list!.add(Task("Room ${i + 1}", job.title, "finishing", i, false));
      }
      if (i < job.bathrooms) {
          task_list!.add(Task("Bathroom ${i + 1}", job.title, "covering", i, false));
          task_list!.add(Task("Bathroom ${i + 1}", job.title, "filler", i, false));
          task_list!.add(Task("Bathroom ${i + 1}", job.title, "sanding", i, false));
          task_list!.add(Task("Bathroom ${i + 1}", job.title, "primer", i, false));
          task_list!.add(Task("Bathroom ${i + 1}", job.title, "first_coat", i, false));
          task_list!.add(Task("Bathroom ${i + 1}", job.title, "final_coat", i, false));
          task_list!.add(Task("Bathroom ${i + 1}", job.title, "finishing", i, false));
      }
      if (i < job.kitchens) {
          task_list!.add(Task("Kitchen ${i + 1}", job.title, "covering", i, false));
          task_list!.add(Task("Kitchen ${i + 1}", job.title, "filler", i, false));
          task_list!.add(Task("Kitchen ${i + 1}", job.title, "sanding", i, false));
          task_list!.add(Task("Kitchen ${i + 1}", job.title, "primer", i, false));
          task_list!.add(Task("Kitchen ${i + 1}", job.title, "first_coat", i, false));
          task_list!.add(Task("Kitchen ${i + 1}", job.title, "final_coat", i, false));
          task_list!.add(Task("Kitchen ${i + 1}", job.title, "finishing", i, false));
      }
      if (i < job.livingRooms) {
          task_list!.add(Task("Living Room ${i + 1}", job.title, "covering", i, false));
          task_list!.add(Task("Living Room ${i + 1}", job.title, "filler", i, false));
          task_list!.add(Task("Living Room ${i + 1}", job.title, "sanding", i, false));
          task_list!.add(Task("Living Room ${i + 1}", job.title, "primer", i, false));
          task_list!.add(Task("Living Room ${i + 1}", job.title, "first_coat", i, false));
          task_list!.add(Task("Living Room ${i + 1}", job.title, "final_coat", i, false));
          task_list!.add(Task("Living Room ${i + 1}", job.title, "finishing", i, false));
      }
      if (i < job.hallways) {
          task_list!.add(Task("Hallway ${i + 1}", job.title, "covering", i, false));
          task_list!.add(Task("Hallway ${i + 1}", job.title, "filler", i, false));
          task_list!.add(Task("Hallway ${i + 1}", job.title, "sanding", i, false));
          task_list!.add(Task("Hallway ${i + 1}", job.title, "primer", i, false));
          task_list!.add(Task("Hallway ${i + 1}", job.title, "first_coat", i, false));
          task_list!.add(Task("Hallway ${i + 1}", job.title, "final_coat", i, false));
          task_list!.add(Task("Hallway ${i + 1}", job.title, "finishing", i, false));
      }
      if (i < job.balconies) {
          task_list!.add(Task("Balcony ${i + 1}", job.title, "covering", i, false));
          task_list!.add(Task("Balcony ${i + 1}", job.title, "filler", i, false));
          task_list!.add(Task("Balcony ${i + 1}", job.title, "sanding", i, false));
          task_list!.add(Task("Balcony ${i + 1}", job.title, "primer", i, false));
          task_list!.add(Task("Balcony ${i + 1}", job.title, "first_coat", i, false));
          task_list!.add(Task("Balcony ${i + 1}", job.title, "final_coat", i, false));
          task_list!.add(Task("Balcony ${i + 1}", job.title, "finishing", i, false));
      }
      if (i < job.garages) {
          task_list!.add(Task("Garage ${i + 1}", job.title, "covering", i, false));
          task_list!.add(Task("Garage ${i + 1}", job.title, "filler", i, false));
          task_list!.add(Task("Garage ${i + 1}", job.title, "sanding", i, false));
          task_list!.add(Task("Garage ${i + 1}", job.title, "primer", i, false));
          task_list!.add(Task("Garage ${i + 1}", job.title, "first_coat", i, false));
          task_list!.add(Task("Garage ${i + 1}", job.title, "final_coat", i, false));
          task_list!.add(Task("Garage ${i + 1}", job.title, "finishing", i, false));
      }
      if (i < job.otherRooms) {
          task_list!.add(Task("Other Room ${i + 1}", job.title, "covering", i, false));
          task_list!.add(Task("Other Room ${i + 1}", job.title, "filler", i, false));
          task_list!.add(Task("Other Room ${i + 1}", job.title, "sanding", i, false));
          task_list!.add(Task("Other Room ${i + 1}", job.title, "primer", i, false));
          task_list!.add(Task("Other Room ${i + 1}", job.title, "first_coat", i, false));
          task_list!.add(Task("Other Room ${i + 1}", job.title, "final_coat", i, false));
          task_list!.add(Task("Other Room ${i + 1}", job.title, "finishing", i, false));
      }
    }
  }

  //init db
  // Box init_db() {
  //   return Hive.openBox('tasks');
  // }
}