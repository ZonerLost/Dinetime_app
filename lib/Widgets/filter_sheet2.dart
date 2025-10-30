// lib/Widgets/filter_sheet2.dart
import 'package:flutter/material.dart';
import '../Constants/app_colors.dart';
import '../Models/filter_model.dart';
import '../Widgets/custom_text_widget.dart';

class FilterSheet2 extends StatefulWidget {
  const FilterSheet2({
    super.key,
    required this.initial,
    this.onChanged,
    this.onApply,
  });

  final FilterData initial;
  final ValueChanged<FilterData>? onChanged;
  final ValueChanged<FilterData>? onApply;

  @override
  State<FilterSheet2> createState() => _FilterSheet2State();
}

class _FilterSheet2State extends State<FilterSheet2> {
  late HgGender _gender;

  // SINGLE-ENDED AGE SLIDER: user controls only the upper bound
  late double _ageMax;

  late BillOption _bill;
  late Set<Category> _cats;

  @override
  void initState() {
    super.initState();
    _gender = widget.initial.gender;
    _ageMax = widget.initial.ageTo.toDouble();   // user moves this only
    _bill   = widget.initial.bill;
    _cats   = {...widget.initial.categories};
  }

  void _emit() {
    final data = widget.initial.copyWith(
      gender: _gender,
      ageFrom: widget.initial.minAge,            // fixed lower bound
      ageTo: _ageMax.round(),                    // from slider
      bill: _bill,
      categories: _cats,
    );
    widget.onChanged?.call(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    const double kMaxHeight = 510;

    return SafeArea(
      top: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: kMaxHeight),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: const BoxDecoration(
              color: Color(0xF5111111),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // handle
                Center(
                  child: Container(
                    width: 129, height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // title + close
                SizedBox(
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(child: headingText('Filter', size: 26, color: Colors.white)),
                      Positioned(
                        right: -8,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          splashRadius: 18,
                          icon: const Icon(Icons.close, color: Colors.white, size: 26),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: bodyText(
                      'Adjust your discovery preferences.',
                      size: 14,
                      color: Colors.white.withOpacity(0.80),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Gender
                headingText('Gender', size: 18, color: Colors.white),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 16,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _radioChip('Any',    selected: _gender == HgGender.any,    onTap: () { _gender = HgGender.any;    _emit(); }),
                    _radioChip('Male',   selected: _gender == HgGender.male,   onTap: () { _gender = HgGender.male;   _emit(); }),
                    _radioChip('Female', selected: _gender == HgGender.female, onTap: () { _gender = HgGender.female; _emit(); }),
                    _radioChip('Other',  selected: _gender == HgGender.other,  onTap: () { _gender = HgGender.other;  _emit(); }),
                  ],
                ),

                const SizedBox(height: 14),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    headingText('Age Range', size: 15, color: Colors.white),

                  ],
                ),
                const SizedBox(height: 8),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3.0,
                    inactiveTrackColor: Colors.white24,
                    activeTrackColor: Colors.white,
                    thumbColor: Colors.white,
                    overlayColor: Colors.white24,
                  ),
                  child: Slider(
                    min: widget.initial.minAge.toDouble(),
                    max: widget.initial.maxAge.toDouble(),
                    divisions: widget.initial.maxAge - widget.initial.minAge,
                    value: _ageMax,
                    onChanged: (v) { _ageMax = v; _emit(); },
                  ),
                ),
                bodyText(
                  '${widget.initial.minAge} - ${_ageMax.round()} years',
                  size: 12,
                  color: Colors.white.withOpacity(0.85),
                ),
                const SizedBox(height: 14),

                // Bill Option
                headingText('Bill Option', size: 15, color: Colors.white),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 10,
                  children: [
                    _radioChip('Any',               selected: _bill == BillOption.any,             onTap: () { _bill = BillOption.any;             _emit(); }),
                    _radioChip('Bill Paid',         selected: _bill == BillOption.billPaid,        onTap: () { _bill = BillOption.billPaid;        _emit(); }),
                    _radioChip('Bill Split',        selected: _bill == BillOption.billSplit,       onTap: () { _bill = BillOption.billSplit;       _emit(); }),
                    _radioChip('Prefer Not To Pay', selected: _bill == BillOption.preferNotToPay,  onTap: () { _bill = BillOption.preferNotToPay;  _emit(); }),
                  ],
                ),

                const SizedBox(height: 14),

                // Category
                headingText('Category', size: 15, color: Colors.white),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: [
                    _toggleChip('Dine',  selected: _cats.contains(Category.dine),  onTap: () { _toggleCat(Category.dine); }),
                    _toggleChip('Event', selected: _cats.contains(Category.event), onTap: () { _toggleCat(Category.event); }),
                  ],
                ),

                const Spacer(),

                // Apply
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      final result = widget.initial.copyWith(
                        gender: _gender,
                        ageFrom: widget.initial.minAge,   // fixed
                        ageTo: _ageMax.round(),           // chosen
                        bill: _bill,
                        categories: _cats,
                      );
                      widget.onApply?.call(result);
                      Navigator.of(context).pop(result);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(color: Color(0xFF9CA3AF), width: 0.1),
                      ),
                    ),
                    child: headingText('Apply Filters', size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // helpers

  void _toggleCat(Category c) {
    if (_cats.contains(c)) {
      _cats.remove(c);
    } else {
      _cats.add(c);
    }
    _emit();
  }

  Widget _radioChip(String label, {required bool selected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18, height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.9), width: 1.3),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              margin: const EdgeInsets.all(3.2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? Colors.white : Colors.transparent,
              ),
            ),
          ),
          const SizedBox(width: 8),
          bodyText(label, size: 10, color: Colors.white.withOpacity(selected ? 1.0 : 0.75)),
        ],
      ),
    );
  }

  Widget _toggleChip(String label, {required bool selected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white24, width: 0.8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.black : Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
