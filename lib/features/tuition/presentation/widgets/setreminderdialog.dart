import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/findschool/presentation/widgets/MyPopupMenuButton.dart';

void showSetReminderModal({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: SetReminderModal(),
      );
    },
  );
}

class SetReminderModal extends StatefulWidget {
  const SetReminderModal({super.key});

  @override
  State<SetReminderModal> createState() => _SetReminderModalState();
}

class _SetReminderModalState extends State<SetReminderModal> {
  String selectedReceiveAlert = '3 days before';
  String selectedAlertTime = '9:00 a.m';
  List<String> selectedChannels = ['Push'];

  final List<String> receiveAlertOptions = [
    '1 day before',
    '2 days before',
    '3 days before',
    '1 week before'
  ];

  final List<String> alertTimeOptions = [
    '8:00 a.m',
    '9:00 a.m',
    '10:00 a.m',
    '2:00 p.m',
    '4:00 p.m'
  ];

  void _showTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0065FF),
            ),
          ),
          child: child!,
        );
      },
    ).then((time) {
      if (time != null) {
        setState(() {
          selectedAlertTime = '${time.hourOfPeriod}:${time.minute.toString().padLeft(2, '0')} ${time.period == DayPeriod.am ? 'a.m' : 'p.m'}';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(),

          // Receive Alert
          _buildSection(
            title: 'reminder.receive_alert'.tr(),
            value: selectedReceiveAlert,
            isPopup: true,
            options: receiveAlertOptions,
            onSelect: (value) {
              setState(() {
                selectedReceiveAlert = value;
              });
            },
          ),

          // Alert Time
          _buildSection(
            title: 'reminder.alert_time'.tr(),
            value: selectedAlertTime,
            isPopup: false,
            onTap: () => _showTimePicker(context),
          ),

          // Delivery Channels
          _buildDeliveryChannels(),

          // Buttons
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'reminder.set_reminder'.tr(),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          const SizedBox(height: 4),
          CustomText(
            label: 'reminder.set_alert_description'.tr(),
            fontSize: 14,
            color: const Color(0xFF666666),
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String value,
    bool isPopup = false,
    List<String>? options,
    Function(String)? onSelect,
    VoidCallback? onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          const SizedBox(height: 8),
          if (isPopup && options != null)
            SizedBox(
              width: double.infinity,
              child: MyPopupMenuButton(
                label: value,
                options: options,
                onSelect: onSelect,
                color: const Color(0xFFDEEBFF),
                bordercolor: const Color(0xFF0065FF),
              ),
            )
          else
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFFE1E4E8)
                  )
                ),
                child: Row(
                  children: [
                    CustomText(label: value),
                    Spacer()
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDeliveryChannels() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'reminder.delivery_channels'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildChannelOption('Push'),
              SizedBox(width: 8),
              _buildChannelOption('SMS'),
              SizedBox(width: 8),
              _buildChannelOption('Email'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChannelOption(String channel) {
    bool isSelected = selectedChannels.contains(channel);
    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedChannels.remove(channel);
              } else {
                selectedChannels.add(channel);
              }
            });
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? const Color(0xFF0065FF) : Color(0xFFE1E4E8)
              ),
              color: isSelected ? const Color(0xFFDEEBFF) : Colors.transparent,
            ),
            child: Center(
              child: CustomText(
                label: 'reminder.channel_${channel.toLowerCase()}'.tr(),
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: CustomButton(
        onPressed: () {
          Navigator.of(context).pop();
          // Action pour Save Alert
        },
        isDisabled: false,
        fullWidth: true,
        color: const Color(0xFF0065FF),
        textColor: Colors.white,
        label: 'reminder.save_alert'.tr(),
      ),
    );
  }
}