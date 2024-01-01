import 'dart:io';
// ignore: avoid_relative_lib_imports
import '../lib/crud_operations.dart';

// main
void main() {
  var crud = CRUD();
  int choice;
  do {
    print('''\n
Choose an operation:
1. Create
2. Read
3. Update
4. Delete
5. Save to CSV
6. Load from CSV
7. Exit
''');
  stdout.write("Choose menu (1-7) : ");
  choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
      bool i = true ;
       while(i){
        crud.createItemFromInput();
        stdout.write("\nAdd Item again ? (y/n) :");
        String y = stdin.readLineSync()!;
        if(y != "y"){
            break;  
          }
        }
      case 2:
        crud.readItems();
      case 3:
        crud.updateItemFromInput();
      case 4:
        crud.deleteItemFromInput();
      case 5:
        print("saving data to file");
        // String fileName = stdin.readLineSync()!;
        crud.saveToCSV('../data/data.csv');
        break;
      case 6:
        crud.loadFromCSV('../data/data.csv');
        break;
      case 7:
        print('Exiting...');
        break;
      default:
        print('Invalid choice');
        break;
    }
  } 
  while (choice != 7);
}

