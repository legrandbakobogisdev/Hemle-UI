import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_footer.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';

class CardInformationScreen extends StatefulWidget {
  const CardInformationScreen({super.key});

  @override
  State<CardInformationScreen> createState() => _CardInformationScreenState();
}

class _CardInformationScreenState extends State<CardInformationScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  final TextEditingController _securityCodeController = TextEditingController();

  bool _showCardError = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expirationDateController.dispose();
    _securityCodeController.dispose();
    super.dispose();
  }

  bool get _isFormComplete {
    return _cardNumberController.text.isNotEmpty &&
        _cardHolderController.text.isNotEmpty &&
        _expirationDateController.text.isNotEmpty &&
        _securityCodeController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(children: [_header(), _body(), _footer()]),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'card_info.title'.tr(),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 10),
          CustomText(
            label: 'card_info.desc'.tr(),
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          // Reference ID Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 23, vertical: 14),
            decoration: BoxDecoration(
              color: Color(0xFFE6F0FF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFA3C7FF)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('card_info.reference_id'.tr(), 'PAY206318590R'),

                // Amount Section
                _buildInfoRow('global.amount'.tr(), '4,200.00 XAF'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Card Number Section
          _buildCardNumberSection(),
          const SizedBox(height: 14),

          // Card Holder Section
          _buildCardHolderSection(),
          const SizedBox(height: 14),

          Row(
            spacing: 14,
            children: [
              _buildExpirationDateSection(),

              _buildSecurityCodeSection(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(label: label, fontSize: 12, color: AppColors.textPrimary),
        CustomText(
          label: value,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ],
    );
  }

  Widget _buildCardNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label: 'card_info.card_number'.tr(),
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: _showCardError ? Colors.red : const Color(0xFFE1E4E8),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: _cardNumberController,

            decoration: InputDecoration(
              // isDense: false,
              // contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: '**** **** **** ****',
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _showCardError = value.isNotEmpty && value.length < 16;
              });
            },
          ),
        ),
        if (_showCardError) ...[
          const SizedBox(height: 8),
          CustomText(
            label: 'card_info.invalid_card'.tr(),
            fontSize: 12,
            color: Colors.red,
            fontWeight: FontWeight.w400,
          ),
        ],
      ],
    );
  }

  Widget _buildCardHolderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label: 'card_info.card_holder'.tr(),
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE1E4E8)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _cardHolderController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'card_info.enter_full_name'.tr(),
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            onChanged: (value) => setState(() {}),
          ),
        ),
      ],
    );
  }

  Widget _buildExpirationDateSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'card_info.expiration_date'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE1E4E8)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _expirationDateController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'MM/YY',
                hintStyle: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              keyboardType: TextInputType.datetime,
              onChanged: (value) => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityCodeSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: 'card_info.security_code'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE1E4E8)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _securityCodeController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'CVV',
                hintStyle: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
              onChanged: (value) => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footer(){
    return CustomFooter(label: 'card_info.proceed'.tr(), onPressed: (){}, isDisabled: _isFormComplete,);
  }
}
