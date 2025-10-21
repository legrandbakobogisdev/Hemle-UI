import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

class RoleDropdown extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final String? initialValue;

  const RoleDropdown({
    super.key,
    this.onChanged,
    this.initialValue,
  });

  @override
  State<RoleDropdown> createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String? _selectedRole;

  final List<Map<String, dynamic>> _roles = [
    {
      'value': 'parent',
      'label': 'Parent',
      'icon': Icons.family_restroom,
    },
    {
      'value': 'student', 
      'label': 'Élève',
      'icon': Icons.school,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: Color(0xFFE1E4E8)
        )
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: false,
          value: _selectedRole,
          elevation: 2,
          iconSize: 24,
          dropdownColor: AppColors.background,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          hint: Padding(
            padding: EdgeInsets.only(left: 16),
            child: CustomText(
              label: 'auth.create.select_role'.tr(),
                color: Colors.grey,
                fontSize: 16,
            ),
          ),
          items: _roles.map((Map role) {
            return DropdownMenuItem<String>(
              value: role['value'],
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    CustomText(
                      label: role['label'],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
            
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedRole = newValue;
            });
            widget.onChanged?.call(newValue);
          },
        ),
      ),
    );
  }
}