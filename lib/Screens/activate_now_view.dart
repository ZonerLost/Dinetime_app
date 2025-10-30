import 'package:canada/Constants/responsive.dart';
import 'package:canada/Screens/hungry_active_view.dart';
import 'package:canada/view_model/hungry_active_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/app_colors.dart';
import '../Constants/app_images.dart';
import '../Models/activate_now_model.dart';
import '../Routes/app_routes.dart';
import '../Widgets/custom_text_widget.dart';
import '../view_model/activate_now_view_model.dart';
import '../Models/hungry_now_model.dart';
import '../Widgets/dt_bottom_nav.dart';
import '../view_model/hungry_now_view_model.dart';

class ActivateNowView extends StatelessWidget {
   ActivateNowView({super.key});


   double kTopStripTop   = 8;
   double kHeadingTop    = 12;
   double kSubTop        = 10;
   double kCardTop       = 22;
   double kRowVSpacing   = 12;
   double kCancelTop     = 24;
   double kCtaTop        = 12;
   double kBottomPadding = 8;
  final HungryNowVM hmm = Get.find();
   final vm = Get.put(
     ActivateNowVM(
       const ActivateNowModel(
         heading: 'Activate Hungry Now',
         subheading: 'Connect with people who are looking to\ndine right now',
         items: [
           ActivateNowItem(
             title: '4 Hour Daily',
             subtitle: 'You can activate this feature for up to 4 hours per day',
             icon: ActivateNowIcon.time,
           ),
           ActivateNowItem(
             title: 'Instant Matches',
             subtitle: 'Instantly chat with people who are actively looking to dine',
             icon: ActivateNowIcon.heart,
           ),
           ActivateNowItem(
             title: 'Nearby',
             subtitle: 'See who’s in your area ready to meet',
             icon: ActivateNowIcon.pin,
           ),
         ],
       ),
     ),
   );


   final navVm = Get.put(
     HungryNowVM(
       HungryNowModel(
         topIcon:         app_images.ic_hungry_logo,
         settingsIcon:    app_images.ic_settings,
         avatarIcon:      app_images.ic_tab_profile,
         tabHungry:       app_images.ic_tab_hungry,
         tabDiscover:     app_images.ic_tab_discover,
         tabReservations: app_images.ic_tab_reservations,
         tabChat:         app_images.ic_tab_chat,
         tabProfile:      app_images.ic_tab_profile,
         checkIcon:       app_images.ic_check,
       ),
     ),
     tag: 'activate-nav',
   );

  final HungryActiveVM nav = Get.isRegistered<HungryActiveVM>()
      ? Get.find<HungryActiveVM>()
      : Get.put(createHungryActiveVm());

  @override
  Widget build(BuildContext context) {



    Widget leadingIcon(ActivateNowIcon i) {
      switch (i) {
        case ActivateNowIcon.time:
          return const Icon(Icons.access_time, size: 28, color: AppColors.black);
        case ActivateNowIcon.heart:
          return const Icon(Icons.favorite_border, size: 28, color: AppColors.black);
        case ActivateNowIcon.pin:
          return const Icon(Icons.location_on_outlined, size: 28, color: AppColors.black);
      }
    }

    Widget cardRow(ActivateNowItem item) => Padding(
      padding:  EdgeInsets.symmetric(vertical: kRowVSpacing / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: leadingIcon(item.icon)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headingText(
                  item.title,
                  size: 16 ,
                  color: AppColors.black,
                ),
                const SizedBox(height: 4),
                bodyText(
                  item.subtitle,
                  size: 14,
                  color: AppColors.text,

                ),
              ],
            ),
          ),
        ],
      ),
    );
   return Obx( () {
    print(navVm.isActiveNow.value);
    return navVm.isActiveNow.value ? HungryActiveView()  :  Scaffold(
      backgroundColor: Colors.white,
      // let the bottom bar paint under the bottom inset so it sits flush
      extendBody: true,

      body: SafeArea(
        top: true,
        bottom: false, // avoid extra bottom gap from SafeArea
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: kTopStripTop,
              horizontal: kTopStripTop ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // top mini toggle + settings + avatar (decor)
              Row(
                children: const [
                  SizedBox(width: 4),
                  Icon(Icons.toggle_on, size: 38, color: AppColors.black),
                  Spacer(),
                  Icon(Icons.settings, size: 25, color: AppColors.black),
                  SizedBox(width: 15),
                  CircleAvatar(radius: 18, backgroundColor: Color(0xFFDDDDDD)),
                ],
              ),

              SizedBox(height: kHeadingTop),

              // title + subheading
              headingText(
                vm.model.heading,
                size: 20,
                color: AppColors.black,
                align: TextAlign.center,
              ),
               SizedBox(height: 10),
              bodyText(
                vm.model.subheading,
                size: 12.5,
                color: AppColors.text,
                height: 1.35,
                align: TextAlign.center,
              ),

               SizedBox(  height: context.screenHeight * 0.09,),

              // features card (tight inner padding so left edges line up)
              Column(
                children: [
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Column(
                        children: vm.model.items.map(cardRow).toList(),
                      ),
                    ),
                  ),

                   SizedBox(height: kCancelTop),

                  TextButton(
                    onPressed: (){
                      hmm.isOn.value = false;
                    },
                    child: bodyText('Cancel', size: 14, color: AppColors.black),
                  ),
                ],
              ),

               SizedBox(height: 10),

              SizedBox(
                height: 44,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                      nav.isOn.value = true;
                      navVm.toggleActiveNow();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: headingText('Activate Now', size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),


    );
  });
  }
}
