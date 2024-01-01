// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

class Item {
  int id;
  String name;
  double price;

  Item(this.id, this.name, this.price);
}

class CRUD {
  int id = 1;
  Map<int, Item> data = {};

  void createItem(Item item) {
      item.id = id++;
      data[item.id] = item;
      print('''Item added: ${item.name} with ID: ${item.id}''');
  }

  void readItems() {
    if (data.isNotEmpty) {
      print('Items:');
      data.forEach((itemName, item) {
        print('ID: ${item.id} Item: ${item.name}   Price: ${item.price}');
      });
    } else {
      print('No items found.');
    }
  }

  void updateItem(int id, String newName, double newPrice) {
    var itemToUpdate = data.values.firstWhere(
      (item) => item.id == id,
    );

    if (itemToUpdate != null) {
      itemToUpdate.name = newName;
      itemToUpdate.price = newPrice;
      print('Item with ID $id updated.');
    } else {
      print('ID not found.');
    }
  }

  void deleteItem(int id) {
    var itemToDelete = data.values.firstWhere(
      (item) => item.id == id,
    );

    if (itemToDelete != null) {
      data.remove(itemToDelete.name);
      print('Item with ID $id deleted.');
    } else {
      print('ID not found.');
    }
  }

  void saveToCSV(String fileName) {
    File file = File(fileName);
    if (!file.existsSync()) {
      file.createSync();
    }
    String csvContent = '';
    data.forEach((itemName, item) {
      csvContent += '${item.id},${item.name},${item.price}\n';
    });
    file.writeAsStringSync(csvContent);
    print('Data saved to $fileName');
  }

  void loadFromCSV(String fileName) {
    File file = File(fileName);
    if (file.existsSync()) {
      List<String> lines = file.readAsLinesSync();
      data.clear();

      lines.forEach((line) {
        List<String> parts = line.split(',');
        if (parts.length == 3) {
          var id = int.tryParse(parts[0]);
          var price = double.tryParse(parts[2]);
          
          if (id != null && price != null) {
            var newItem = Item(id, parts[1], price);
            data[newItem.id] = newItem;
          }
        }
      });
      print('Data loaded from $fileName');
    } else {
      print('File $fileName does not exist.');
    }
  }

  void createItemFromInput() {
    stdout.write('Enter Item Name:');
    String name = stdin.readLineSync()!;

    stdout.write('Enter Item Price:');
    double price = double.parse(stdin.readLineSync()!);

    // int id = 0;
    var newItem = Item(id, name, price);
    createItem(newItem);
  }

  void updateItemFromInput() {
    stdout.write('Enter Item ID to update:');
    int id = int.parse(stdin.readLineSync()!);

    stdout.write('Enter New Item Name:');
    String name = stdin.readLineSync()!;

    stdout.write('Enter New Item Price:');
    double price = double.parse(stdin.readLineSync()!);

    updateItem(id, name, price);
  }

  void deleteItemFromInput() {
    print('Enter Item ID to delete:');
    int id = int.parse(stdin.readLineSync()!);

    deleteItem(id);
  }
}