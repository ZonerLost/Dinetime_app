import 'package:get/get.dart';

class FoodInterestViewModel extends GetxController {
  final RxSet<String> selected = <String>{}.obs;

  // Flat list to match the mock
  final List<String> options = const [
    'Italian','Japanese',
    'Mexican','Thai',
    'Indian','Chinese',
    'French','Greek',
    'Korean','Vietnamese',
    'American','Mediterranean',
    'Spanish','Lebanese',
    'Brazilian','Turkish',
    'Ethiopian','Moroccan',
    'Sushi','Ramen',
    'Pizza','Tacos',
    'Burgers','BBQ',
    'Pasta','Dim Sum',
    'Pho','Curry',
    'Sashimi','Tapas',
    'Vegan','Vegetarian',
    'Seafood','Steakhouse',
    'Brunch','Desserts',
    'Ice Cream','Coffee',
    'Cocktails','Wine',
  ];

  bool isSelected(String label) => selected.contains(label);

  void toggle(String label) {
    if (!selected.remove(label)) selected.add(label);
    selected.refresh(); // notify listeners
  }

  Future<void> save() async {
    
  }
}
