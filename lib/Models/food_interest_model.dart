// Text-only model for cuisines (no images)

class FoodItem {
  final String id;      // stable key for API/selection
  final String label;   // what you render on the pill

  const FoodItem({required this.id, required this.label});
}

class FoodInterestModel {
  final List<FoodItem> items;
  const FoodInterestModel({required this.items});

  /// Factory that matches your screenshot (order preserved)
  factory FoodInterestModel.cuisinesTextOnly() {
    FoodItem it(String id, String label) => FoodItem(id: id, label: label);

    return FoodInterestModel(items: [
      it('italian', 'Italian'),         it('japanese', 'Japanese'),
      it('mexican', 'Mexican'),         it('thai', 'Thai'),
      it('indian', 'Indian'),           it('chinese', 'Chinese'),
      it('french', 'French'),           it('greek', 'Greek'),
      it('korean', 'Korean'),           it('vietnamese', 'Vietnamese'),
      it('american', 'American'),       it('mediterranean', 'Mediterranean'),
      it('spanish', 'Spanish'),         it('lebanese', 'Lebanese'),
      it('brazilian', 'Brazilian'),     it('turkish', 'Turkish'),
      it('ethiopian', 'Ethiopian'),     it('moroccan', 'Moroccan'),
      it('sushi', 'Sushi'),             it('ramen', 'Ramen'),
      it('pizza', 'Pizza'),             it('tacos', 'Tacos'),
      it('burgers', 'Burgers'),         it('bbq', 'BBQ'),
      it('pasta', 'Pasta'),             it('dimsum', 'Dim Sum'),
      it('pho', 'Pho'),                 it('curry', 'Curry'),
      it('sashimi', 'Sashimi'),         it('tapas', 'Tapas'),
      it('vegan', 'Vegan'),             it('vegetarian', 'Vegetarian'),
      it('seafood', 'Seafood'),         it('steakhouse', 'Steakhouse'),
      it('brunch', 'Brunch'),           it('desserts', 'Desserts'),
      it('icecream', 'Ice Cream'),      it('coffee', 'Coffee'),
      it('cocktails', 'Cocktails'),     it('wine', 'Wine'),
    ]);
  }
}
