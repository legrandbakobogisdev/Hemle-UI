// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/config/colors/appColors.dart';

class CustomFooter extends StatefulWidget {
  bool? isDisabled;
  String label;
  Widget? icon;
  Widget? otherButton;
  VoidCallback onPressed;
  bool? fullWidth;

  CustomFooter({super.key, required this.label, required this.onPressed, this.icon, this.isDisabled, this.fullWidth = true, this.otherButton});

  @override
  State<CustomFooter> createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: // Proceed Button
          CustomButton(
            onPressed: widget.isDisabled != null ? !widget.isDisabled! == false 
                ? widget.onPressed
                : null : widget.onPressed,
        
            isDisabled: widget.isDisabled != null ? !widget.isDisabled! : false,
            fullWidth: widget.fullWidth!,
            label: widget.label,
            icon: widget.icon,
          ),
        ),

        widget.otherButton != null ? widget.otherButton! : Container(),

      ],
    );
  }
}
