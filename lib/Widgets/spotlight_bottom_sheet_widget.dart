import 'package:canada/Widgets/custom_text_widget.dart';
import 'package:canada/view_model/spotlight_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key,});
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpotlightVM>();
    
    return Container(
      decoration:  BoxDecoration(
      color: Color(0xF5111111),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 90,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                const Column(
                  children: [
                    CustomTextWidget(
                      text:  'Filter',
                      
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      
                    ),
                    SizedBox(height: 4),
                    CustomTextWidget(
                      text:  'Adjust your discovery preferences.',
                     
                        color: Colors.white,
                        fontSize: 14,
                      
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
         
          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cuisine Type Section
                  const CustomTextWidget(
                   text:  'Cuisine Type',
                    
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    
                  ),
                  const SizedBox(height: 16),
                  Obx(() => Wrap(
                    spacing: 9,
                    runSpacing: 9,
                    children: controller.cuisineTypes.map((cuisine) {
                      final isSelected = controller.isCuisineSelected(cuisine);
                      return GestureDetector(
                        onTap: () => controller.toggleCuisine(cuisine),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.black,
                            borderRadius: BorderRadius.circular(14),
                           
                          ),
                          child: CustomTextWidget(
                          text:   cuisine,
                            
                              color: isSelected ? Colors.black : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            
                          ),
                        ),
                      );
                    }).toList(),
                  )),
                  
                  const SizedBox(height: 32),
                  
                  // Price Range Section
                  const CustomTextWidget(
                   text:  'Price Range',
                  
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    
                  ),
                  const SizedBox(height: 16),
                  Obx(() => Row(
                    children: controller.priceRanges.map((price) {
                      final isSelected = controller.isPriceRangeSelected(price);
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () => controller.selectPriceRange(price),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.black,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: CustomTextWidget(
                              text:   price,
                                  color: isSelected ? Colors.black : Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          
          // Bottom buttons
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.clearAllFilters(),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: const Center(
                        child: CustomTextWidget(
                         text:  'Clear All',
                         
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.applyFilters(),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: CustomTextWidget(
                         text:  'Apply Filters',
                          
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}