import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

void showConfirmPaymentModal({
  required BuildContext context,
  required String amount,
  required String method,
  required String recipient,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: ConfirmPaymentModal(
          amount: amount,
          method: method,
          recipient: recipient,
          onConfirm: onConfirm,
        ),
      );
    },
  );
}

class ConfirmPaymentModal extends StatefulWidget {
  final String amount;
  final String method;
  final String recipient;
  final VoidCallback onConfirm;

  const ConfirmPaymentModal({
    super.key,
    required this.amount,
    required this.method,
    required this.recipient,
    required this.onConfirm,
  });

  @override
  State<ConfirmPaymentModal> createState() => _ConfirmPaymentModalState();
}

class _ConfirmPaymentModalState extends State<ConfirmPaymentModal> {
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

          // Invoice Section
          _buildInvoiceSection(),

          Container(height: 60),

          // Download PDF
          _buildDownloadPdf(),

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
            label: 'payment.confirm_payment'.tr(),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          const SizedBox(height: 4),
          CustomText(
            label: 'payment.review_info'.tr(),
            fontSize: 14,
            color: const Color(0xFF666666),
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'payment.invoice'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          _buildInvoiceRow('payment.amount'.tr(), widget.amount),
          _buildInvoiceRow('payment.method'.tr(), widget.method),
          _buildInvoiceRow('payment.recipient'.tr(), widget.recipient),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: CustomText(
              label: label,
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 3,
            child: CustomText(
              label: value,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadPdf() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5
      ),
      child: CustomButton(
        onPressed: () {
          Navigator.of(context).pop();
          widget.onConfirm();
        },
        isDisabled: false,
        fullWidth: true,
        color: Colors.transparent,
        border: Border.all(
          color: Color(0xFFE1E4E8)
        ),
        textColor: AppColors.black,
        label: 'payment.downloadpdfreceipt'.tr(),
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: CustomButton(
        onPressed: () {
          Navigator.of(context).pop();
          widget.onConfirm();
        },
        isDisabled: false,
        fullWidth: true,
        color: const Color(0xFF0065FF),
        textColor: Colors.white,
        label: 'payment.confirm_continue'.tr(),
      ),
    );
  }
}