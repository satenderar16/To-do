// import 'dart:convert';

import 'package:appml/todo_model.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';


class TodoController extends GetxController {
  //varible for the selection of item indictor
  RxBool SelectionUI = false.obs;
  void isSelected() {
    SelectionUI.value = !SelectionUI.value;
  }

  //variable for selectedindex ontap
  RxInt indexOcard = 0.obs;
  // creating and to-do and related fucntio:
  var todos = [].obs;

  bool todosEmpty(){
    return todos.isEmpty;
  }

  void addTodo(TodoElement todo) {
    todos.add(todo);
    // saveTodos();
  }

  void removeTodoAt(int index) {
    todos.removeAt(index);
  }

  // selection related fucntion for the selection and deletion
  var SeletionOIndices = <int>{}.obs;

  void toggleSelection(int index) {
    if (SeletionOIndices.contains(index)) {
      SeletionOIndices.remove(index);
    } else {
      SeletionOIndices.add(index);
    }
  }
  bool isSelectItem(int index) {
    return SeletionOIndices.contains(index); // Check if an index is selected
  }

  void deleteSelected() {
    // Sort indices in descending order to prevent index shifting during removal
    final indicesToRemove = SeletionOIndices.toList()..sort((a, b) => b.compareTo(a));

    for (int index in indicesToRemove) {
      todos.removeAt(index);
    }


    SeletionOIndices.clear(); // Clear selection after deletion
  }
  void selectAll() {
    // Select all indices from 0 to the length of the todos list
    SeletionOIndices.addAll(List.generate(todos.length, (index) => index));
  }

  @override
  void onInit() {
    super.onInit();
    todos.addAll([
      TodoElement(
          title: 'Buy Groceries',
          note: 'Milk, Eggs, Bread',
          tags: ['shopping']),
      TodoElement(
          title: 'Complete Homework',
          note: 'Math and Science',
          tags: ['study', 'urgent']),
      TodoElement(
        title: 'duck duck',
        note: "fuck fuckThe search bar or search box component is a search field that allows the user to enter a search query. This component can also be part of the App Bar and includes a submit button or search icon that executes the search query. Once executed builtin algorithm can be executed or a call can be made to a 3rd party Search API that provides the matching results",
        tags: ['uah', 'aouhoa', 'afosdh', 'audha'],
      ),
    ]);
  }








}


