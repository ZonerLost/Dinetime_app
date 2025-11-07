import 'package:canada/Constants/app_colors.dart';
import 'package:canada/Constants/responsive.dart';
import 'package:canada/Models/hotandtrend_model.dart';
import 'package:canada/Widgets/custom_text_input_widget.dart';
import 'package:canada/Widgets/custom_text_widget.dart';
import 'package:canada/view_model/hotandtrend_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailsHotandtrendSheetWidget extends StatelessWidget {
  DetailsHotandtrendSheetWidget({
    super.key,
    required this.scrollController,
  }) : viewModel = Get.put(HotandtrendViewModel());

  final ScrollController scrollController;
  final HotandtrendViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel.selectedTab.value.isEmpty && listMenuTab.isNotEmpty) {
      viewModel.setTab(listMenuTab.first.title);
    }

    final HotandtrendModel? details =
        listHotandTrendList.isNotEmpty ? listHotandTrendList.first : null;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: context.screenWidth,
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha:  0.88),
          border: Border(
            top: BorderSide(color: AppColors.gray400.withValues(alpha: 0.35)),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            
            children: [
              const Divider(endIndent: 150, indent: 150, thickness: 4, color: AppColors.background,),
              Align(alignment: Alignment.topRight,
              child: IconButton(onPressed: (){
                Get.back();
              }, 
              icon: Icon(Icons.close, size: 28,)), ),
              const SizedBox(height: 1),
              Expanded(
                child: ListView(
                  controller: scrollController,
                              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  children: [
                    if (details != null) ...[
                  _ImageGallery(images: details.images),
                  const SizedBox(height: 20),
                  _InfoSection(model: details),
                  const SizedBox(height: 24),
                ],
                _TabSelector(viewModel: viewModel),
                const SizedBox(height: 18),
                Obx(() {
                  final selected = viewModel.selectedTab.value;
                  switch (selected) {
                    case 'Menu':
                      return const _MenuList();
                    case 'Reservation':
                      return  _ReservationDetails(hotandtrendViewModel: viewModel,);
                    default:
                      return const SizedBox.shrink();
                  }
                }),
                  ],
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}



class _ImageGallery extends StatelessWidget {
  const _ImageGallery({required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          final asset = images[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              asset,
              width: 160,
              height: 120,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.model});

  final HotandtrendModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        const SizedBox(height: 12),
        Transform.translate(
          offset: Offset(-2, 0),
          child: _InfoTile(
            iconAsset: model.iconLocation,
            height: 22,
            width: 22,
            label: model.locationAddres,
          ),
        ),
        const SizedBox(height: 16),
        _InfoTile(
          iconAsset: model.timeIcon,
          label: model.timeDetails,
        ),
        const SizedBox(height: 16),
        _InfoTile(
          iconAsset: model.phoneIcon,
          height: 17,
          width: 17,
          label: model.phoneNumber,
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.iconAsset, 
  this.height, this.width,
  required this.label});

  final String iconAsset;
  final String label;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconAsset,
          width: height ?? 18,
          height: width ?? 18,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: bodyText(
            label,
            size: 14,
            color: Colors.white.withValues(alpha: 0.78),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _TabSelector extends StatelessWidget {
  const _TabSelector({required this.viewModel});

  final HotandtrendViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blackshade1.withValues(alpha: 0.3),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Obx(() {
        final selected = viewModel.selectedTab.value;
        return Row(
          children: [
            for (var i = 0; i < listMenuTab.length; i++) ...[
              Expanded(
                child: GestureDetector(
                  onTap: () => viewModel.setTab(listMenuTab[i].title),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: listMenuTab[i].title == selected
                          ? AppColors.black
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                     
                    ),
                    child: bodyText(
                      listMenuTab[i].title,
                      size: 13,
                      color: Colors.white,
                      align: TextAlign.center,
                      weight: listMenuTab[i].title == selected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
              if (i != listMenuTab.length - 1) const SizedBox(width: 12),
            ],
          ],
        );
      }),
    );
  }
}

class _MenuList extends StatelessWidget {
  const _MenuList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(listMenuModel.length, (i) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.blackshade1.withValues(alpha: 0.2), 
        borderRadius: BorderRadius.circular(10), 
        border: Border.all(color: AppColors.gray200.withValues(alpha: 0.2))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
            headingText(
              listMenuModel[i].title,
              size: 15,
              color: Colors.deepOrange,
            ),
            const SizedBox(height: 10),
            ...listMenuModel[i].menuItemDetails.map((item) {
              return _MenuItemTile(item: item);
            }),
            if (i != listMenuModel.length - 1) const SizedBox(height: 18),
          ],
        
      ),
    );
      }),
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  const _MenuItemTile({required this.item});

  final MenuItemDetail item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bodyText(
                  item.itemName,
                  size: 13,
                  color: Colors.white,
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 4),
                bodyText(
                  item.itemGradients,
                  size: 11,
                  color: Colors.white.withValues(alpha:  0.72),
                  height: 1.35,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          bodyText(
            '\$${item.price.toStringAsFixed(2)}',
            size: 12,
            color: Colors.deepOrange,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

class _ReservationDetails extends StatelessWidget {
   _ReservationDetails({required this.hotandtrendViewModel});

  final HotandtrendViewModel hotandtrendViewModel;

  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyText(
            'Make a Reservation',
            size: 13,
            color: Colors.white,
            weight: FontWeight.w600,
          ),
          const SizedBox(height: 10),
          CustomTextWidget(text: "Date",  color: AppColors.background.withValues(alpha: 0.7), 
          fontSize: 18,),
       CustomTextInputWidget(controller: date,
             fillColor: AppColors.blackshade1.withValues(alpha: 0.5),
             hintText: "Select Date",
            ontap: ()async{
             await hotandtrendViewModel.pickDate();

            date.text = hotandtrendViewModel.selectedDate.value != null
              ? DateFormat('dd MMM yyyy').format(hotandtrendViewModel.selectedDate.value!) : '';

            },
             isReadOnly: true,
             inputFontColor: AppColors.background,
             suffixIcon: Icon(Icons.calendar_month, color: AppColors.background.withValues(alpha: 0.6),),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
          const SizedBox(height: 10),
          CustomTextWidget(text: "Time",  color: AppColors.background.withValues(alpha: 0.7), 
          fontSize: 18,),
       CustomTextInputWidget(controller: time,
             fillColor: AppColors.blackshade1.withValues(alpha: 0.5),
             hintText: "Select Date",
            ontap: ()async{
             await hotandtrendViewModel.pickTime();

            final selectedTime = hotandtrendViewModel.selectedTime.value;
            time.text = selectedTime != null
                ? selectedTime.format(context)
                : '';

            },
             isReadOnly: true,
             inputFontColor: AppColors.background,
             suffixIcon: Icon(Icons.watch_later_outlined, color: AppColors.background.withValues(alpha: 0.6),),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
          const SizedBox(height: 10),

          CustomTextWidget(text: "Party Size",  color: AppColors.background.withValues(alpha: 0.7), 
          fontSize: 18,),
       CustomTextInputWidget(controller: time,
             fillColor: AppColors.blackshade1.withValues(alpha: 0.5),
             hintText: "E.g 2 person",
           
             isReadOnly: true,
             inputFontColor: AppColors.background,
            
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
          
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: bodyText(
                'Reserve Table',
                size: 13,
                color: AppColors.white,
                weight: FontWeight.w600,
                align: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
