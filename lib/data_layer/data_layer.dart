import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;
  Map? currentUserInfo;

  String? firstTimeJoin;

  final box = GetStorage();
  List<Map<String, dynamic>> itemsList = [];

  int? orderID;

  DataLayer() {
    // box.erase();
    loadData();
  }

  void addToCart({required Map<String, dynamic> item}) {
    // box.erase();
    // Retrieve the existing items from storage
    List<Map<String, dynamic>> itemsList = viewCartItems();

    // Check if the item already exists based on the product_id
    int existingItemIndex = itemsList.indexWhere(
        (existingItem) => existingItem['product_id'] == item['product_id']);

    if (existingItemIndex == -1) {
      // If the item does not exist, set a default quantity and add it
      item['quantity'] = 1; // Set default quantity
      itemsList.add(item); // Add the new item to the list
    } else {
      // If the item exists, increment its quantity
      incrementItemQuantity(itemsList[existingItemIndex]);
    }

    box.write('ProductsList', itemsList);
  }

  void incrementItemQuantity(Map<String, dynamic> item) {
    // Increment quantity
    item['quantity'] = (item['quantity'] ?? 0) + 1;
    print('Item quantity updated to: ${item['quantity']}');
  }

  void decrementItemQuantity({required Map<String, dynamic> item}) {
    // Retrieve the existing items from storage
    List<Map<String, dynamic>> itemsList = viewCartItems();

    // Find the index of the item in the list
    int existingItemIndex = itemsList.indexWhere(
        (existingItem) => existingItem['product_id'] == item['product_id']);

    if (existingItemIndex != -1) {
      // Decrement the quantity safely
      itemsList[existingItemIndex]['quantity'] =
          (itemsList[existingItemIndex]['quantity'] ?? 1) - 1;

      // Check if the quantity is now 0 or less
      if (itemsList[existingItemIndex]['quantity'] <= 0) {
        // Remove the item from the list
        itemsList.removeAt(existingItemIndex);
      }

      // Store the updated list back in the box
      box.write('ProductsList', itemsList);
    }
  }

  void removeFromCart({required Map<String, dynamic> item}) {
    //func to remove from cart
  }

  List<Map<String, dynamic>> viewCartItems() {
    // Retrieve the stored item
    var storedItem = box.read('ProductsList') ?? [];
    return List<Map<String, dynamic>>.from(storedItem);
  }

  getUserInfo() async {
    currentUserInfo = await supabase
        .from("users")
        .select()
        .eq("user_id", supabase.auth.currentUser!.id)
        .single();

    box.write("currentUser", currentUserInfo);
  }

  firstVisit() {
    firstTimeJoin = "true";
    box.write("firstTime", "true");
  }

  loadData() {
    if (box.hasData("currentUser")) {
      currentUserInfo = box.read("currentUser");
    }

    if (box.hasData("firstTime")) {
      firstTimeJoin = box.read("firstTime");
    }
  }
}
