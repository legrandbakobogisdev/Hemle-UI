import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? textColor;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final Widget? icon;
  final MainAxisAlignment alignment;
  final bool isLoading;
  final bool isDisabled;
  final bool expand;
  final bool fullWidth;
  final bool outlined;
  final bool elevated;
  final bool textButton;
  final bool iconButton;
  final IconAlignment? iconalignment;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.padding = const EdgeInsets.all(12.0),
    this.color,
    this.borderRadius = 8.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
    this.textColor,
    this.width,
    this.height,
    this.border,
    this.icon,
    this.iconalignment,
    this.alignment = MainAxisAlignment.center,
    this.isLoading = false,
    this.isDisabled = false,
    this.expand = false,
    this.fullWidth = false,
    this.outlined = false,
    this.elevated = false,
    this.textButton = false,
    this.iconButton = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: widget.icon ?? const SizedBox.shrink(),
      iconAlignment: widget.iconalignment,
      label: widget.isLoading == true
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                    widget.textColor ?? Colors.white),
              ),
            )
          : CustomText(
              label: widget.label,
              fontSize: widget.fontSize,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontWeight: widget.fontWeight,
              color: widget.textColor ?? Colors.white,
              textAlign: TextAlign.center,
            ),
      style: ElevatedButton.styleFrom(
        padding: widget.padding,
        backgroundColor: widget.color ?? Color(0xFF0065FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          side: widget.border != null
              ? (widget.border as Border).top
              : BorderSide.none,
        ),
        minimumSize: widget.fullWidth
            ? Size(double.infinity, widget.height ?? 48)
            : widget.width != null && widget.height != null
            ? Size(widget.width!, widget.height!)
            : widget.width != null
            ? Size(widget.width!, 48)
            : widget.height != null
            ? Size(100, widget.height!)
            : const Size(100, 48),
        elevation: widget.elevated ? 4.0 : 0.0,
      ),

      onPressed: widget.isDisabled || widget.isLoading
          ? null
          : widget.onPressed,
      
    );
  }
}
