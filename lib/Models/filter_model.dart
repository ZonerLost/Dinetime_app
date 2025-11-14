// lib/Models/filter_model.dart
enum HgGender { any, male, female, other }
enum BillOption { any, billPaid, billSplit, preferNotToPay }
enum Category { dine, event }

class FilterData {
  // Gender
  final HgGender gender;

  // Age range
  final int minAge;       // absolute bounds (UI)
  final int maxAge;       // absolute bounds (UI)
  final int ageFrom;      // selected lower bound
  final int ageTo;        // selected upper bound

  // Bill option (single select)
  final BillOption bill;

  // Category (multi-select, but your mock shows two)
  final Set<Category> categories;

  const FilterData({
    this.gender = HgGender.any,
    this.minAge = 18,
    this.maxAge = 100,
    this.ageFrom = 18,
    this.ageTo = 75,
    this.bill = BillOption.any,
    this.categories = const {Category.dine},
  }) : assert(ageFrom >= 0),
        assert(ageTo >= ageFrom);

  FilterData copyWith({
    HgGender? gender,
    int? minAge,
    int? maxAge,
    int? ageFrom,
    int? ageTo,
    BillOption? bill,
    Set<Category>? categories,
  }) {
    return FilterData(
      gender: gender ?? this.gender,
      minAge:  minAge  ?? this.minAge,
      maxAge:  maxAge  ?? this.maxAge,
      ageFrom: ageFrom ?? this.ageFrom,
      ageTo:   ageTo   ?? this.ageTo,
      bill:    bill    ?? this.bill,
      categories: categories ?? this.categories,
    );
  }
}
