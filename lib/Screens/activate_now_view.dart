import 'package:canada/Constants/responsive.dart';
import 'package:canada/Screens/hungry_active_view.dart';
import 'package:canada/Widgets/spacer_widget.dart';
import 'package:canada/view_model/hungry_active_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/app_colors.dart';
import '../Constants/app_images.dart';
import '../Models/activate_now_model.dart';
import '../Widgets/custom_text_widget.dart';
import '../view_model/activate_now_view_model.dart';
import '../Models/hungry_now_model.dart';
import '../view_model/hungry_now_view_model.dart';

class ActivateNowView extends StatelessWidget {
   ActivateNowView({super.key, HungryNowVM? hostVm})
     : hostVm = hostVm ?? _resolveHungryVm();


   double kTopStripTop   = 18;
   double kHeadingTop    = 7;
   double kSubTop        = 10;
   double kCardTop       = 22;
   double kRowVSpacing   = 12;
   double kCancelTop     = 24;
   double kCtaTop        = 12;
   double kBottomPadding = 8;
  final HungryNowVM hostVm;
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


  final HungryActiveVM hungryActiveVm = Get.isRegistered<HungryActiveVM>()
      ? Get.find<HungryActiveVM>()
      : Get.put(createHungryActiveVm());

  static HungryNowVM _resolveHungryVm() {
    if (Get.isRegistered<HungryNowVM>()) {
      return Get.find<HungryNowVM>();
    }
    return Get.put(
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
    );
  }

  Widget _leadingIcon(ActivateNowIcon i) {
    switch (i) {
      case ActivateNowIcon.time:
        return Container(
           padding: EdgeInsets.symmetric(horizontal:  6, vertical: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle, 
            border: Border.all(color: AppColors.black_text.withValues(alpha: 0.8))
          ),
          child: const Icon(Icons.access_time, size: 25, color: AppColors.black));
      case ActivateNowIcon.heart:
        return Container(
          padding: EdgeInsets.symmetric(horizontal:  2, vertical: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle, 
            border: Border.all(color: AppColors.black_text.withValues(alpha: 0.8))
          ),
          child: Center(child: const Icon(Icons.favorite_border, 
          size: 25, color: AppColors.black)));
      case ActivateNowIcon.pin:
        return Container(
          padding: EdgeInsets.symmetric(horizontal:  6, vertical: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle, 
            border: Border.all(color: AppColors.black_text.withValues(alpha: 0.8))
          ),
          child: const Icon(Icons.location_on_outlined, size: 25, color: AppColors.black));
    }
  }

  Widget _cardRow(ActivateNowItem item) => Padding(
      padding:  EdgeInsets.symmetric(vertical: kRowVSpacing / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: _leadingIcon(item.icon)),
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
   Widget _buildContent(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
    
      extendBody: true,

      body: SafeArea(
        top: true,
        bottom: false, 
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: kTopStripTop,
              horizontal: kTopStripTop ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
             
              Row(
                children: const [
                  SizedBox(width: 4),
                  Icon(Icons.toggle_on, size: 38, color: AppColors.black),
                  Spacer(),
                  Icon(Icons.settings, size: 25, color: AppColors.black),
                  SizedBox(width: 15),
                  CircleAvatar(radius: 18, backgroundImage: AssetImage(app_images.picture1), backgroundColor: Color(0xFFDDDDDD)),
                ],
              ),

              SpacerWidget(height: kHeadingTop),

              // title + subheading
              CustomTextWidget(
               text:  vm.model.heading,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                textAlign: TextAlign.center,
              ),
               SpacerWidget(height: 2),
              CustomTextWidget(
               text:  vm.model.subheading,
                fontSize: 18,
                color: AppColors.text,
                
                textAlign: TextAlign.center,
              ),

               SpacerWidget(height: 4,),
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
                        children: vm.model.items.map(_cardRow).toList(),
                      ),
                    ),
                  ),

                   SizedBox(height: kCancelTop),
                  SizedBox(
                height: 50,
                width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      hungryActiveVm.isOn.value = true;
                      hostVm.showHungryActive();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                  ),
                  child: headingText('Activate Now', 
                  size: 16, color: Colors.white),
                ),
              ),
              
               SpacerWidget(height: 3),
                  TextButton(
                    onPressed: (){
                      hostVm.showLanding();
                    },
                    child: bodyText('Cancel', size: 14, color: AppColors.black),
                  ),
                ],
              ),


              
            ],
          ),
        ),
      ),
    );
   }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (hostVm.subPage.value == HungrySubPage.hungryActive) {
        return HungryActiveView(hostVm: hostVm);
      }
      return _buildContent(context);
    });
  }
}
