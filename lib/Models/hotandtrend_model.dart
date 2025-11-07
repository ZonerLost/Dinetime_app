import 'package:canada/Constants/app_images.dart';

class MenuTabModel {
  final String title;

  MenuTabModel({required this.title});
}


List<MenuTabModel> listMenuTab = [
  MenuTabModel(title: "Menu"),
  MenuTabModel(title: "Reservation")

];


class HotandtrendModel {

  final List<String> images;
  final String iconLocation; 
  final String locationAddres; 
  final String timeIcon;
  final String timeDetails;
  final String phoneIcon;
  final String phoneNumber;

  HotandtrendModel({required this.images, 
  required this.iconLocation, 
  required this.locationAddres, 
  required this.phoneIcon, 
  required this.phoneNumber,
  required this.timeDetails, 
  required this.timeIcon,});

}

class MenuModel {
  final String title;
  final List<MenuItemDetail> menuItemDetails;

  MenuModel({required this.menuItemDetails, 
  required this.title});

}

class MenuItemDetail {
  final String itemName;
  final String itemGradients;
  final double price;

  MenuItemDetail({required this.itemGradients, required this.itemName, required this.price});
}


  List<MenuModel> listMenuModel = [
    MenuModel(menuItemDetails: [
      MenuItemDetail(itemGradients: "Angus beef, cheddar, lettuce, tomato, special sauce", 
      itemName: "Classic Place Burger", price: 15.99),
      MenuItemDetail(itemGradients: "Caramelized onions, becon, BBQ sauce", 
      itemName: "BBQ Becon Burger", price: 13.99)
    ], title: "Burger"),
    MenuModel(menuItemDetails: [
      MenuItemDetail(itemGradients: "Beer-battered crispy onion rings", 
      itemName: "Onion Rings", price: 6.99),
      MenuItemDetail(itemGradients: "Hand-cut fries with truffle oil and parmesan", 
      itemName: "Truffle Fries", price: 11.99)
    ], title: "Side")
  ];


List<HotandtrendModel> listHotandTrendList = [
HotandtrendModel(images: [
  "assets/images/detailImage.jpg",
  "assets/images/detailmage2.jpg",
  "assets/images/detailImage3.jpg"
], 
iconLocation: app_images.tdesign_location, 
locationAddres: '123 main street New York NY 1001', 
phoneIcon: app_images.phoneIcon, 
phoneNumber: '555-123-1233', 
timeDetails: 'Mon-fri: 11Am -10Pm, Sat-Sun 10Am-11PM', 
timeIcon: app_images.timeIcon)
];