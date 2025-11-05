// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class MyPopupMenuButton extends StatefulWidget {
  final Function(String)? onSelect;
  final List<String> options;
  final String? label;
  final Color? color;
  final Color? bordercolor;
  const MyPopupMenuButton({
    super.key,
    this.onSelect,
    required this.options,
    this.label,
    this.color,
    this.bordercolor
  });

  @override
  _MyPopupMenuButtonState createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      enableFeedback: false,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      elevation: 1,
      shadowColor: Colors.transparent,
      style: const ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Colors.transparent)
      ),
      itemBuilder: (context) => widget.options.map((option) {
        return PopupMenuItem(
          value: option,
          height: 40,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: _buildOptionItem(option, isSelected: _selectedValue == option),
          ),
        );
      }).toList(),
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          width: 1,
          color: Color(0xFFE1E4E8)
        )
      ),
      onSelected: (value) {
        setState(() {
          _selectedValue = value;
        });
        widget.onSelect?.call(_selectedValue!);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedValue != null ? const Color(0xFF0065FF) : widget.bordercolor ?? Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
          color: widget.color ??
              (_selectedValue != null
                  ? const Color(0xFFDEEBFF)
                  : Colors.transparent),
        ),
        child: widget.label != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomText(
                      label: widget.label!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(IconsaxPlusLinear.arrow_down, size: 14),
                ],
              )
            : _selectedValue != null
            ? Image.asset("assets/images/32.png")
            : Image.asset("assets/images/31.png"),
      ),
    );
  }

  Widget _buildOptionItem(String option, {bool isSelected = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelected ? const Color(0xFFDEEBFF) : Colors.transparent
      ),
      child: CustomText(
        label: option,
        fontSize: 14,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        color: isSelected ? AppColors.primary : Colors.black87,
      ),
    );
  }
}