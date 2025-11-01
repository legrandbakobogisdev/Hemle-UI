import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_button.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/findschool/presentation/widgets/MyPopupMenuButton.dart';
import 'package:hemle/features/home/data/models/home_models.dart';
import 'package:hemle/features/paymentgateway/presentation/screens/methodPayment_screen.dart';
import 'package:hemle/features/tuition/presentation/widgets/setreminderdialog.dart';

class TuitionScreen extends StatefulWidget {
  const TuitionScreen({super.key});

  @override
  State<TuitionScreen> createState() => _TuitionScreenState();
}

class _TuitionScreenState extends State<TuitionScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Map<String, dynamic>> _switcherButtons = [
    {'label': 'tuition.current'.tr(), 'index': 0},
    {'label': 'tuition.history'.tr(), 'index': 1},
    {'label': 'tuition.upcoming'.tr(), 'index': 2},
  ];

  bool _filterActive = false;
  String? _selectedChild;
  String? _selectedSchool;
  final TextEditingController _searchController = TextEditingController();

  // Liste des transactions
  final List<Map<String, dynamic>> _allTransactions = [
    {
      'id': '1',
      'childName': 'Amara Fobi',
      'schoolName': 'Maarif School',
      'date': '09/09/2025',
      'amount': '4,200 XAF',
      'status': 'approved',
      'isSelected': false,
    },
    {
      'id': '2',
      'childName': 'Jean-Baptiste Fobi',
      'schoolName': 'Maarif School',
      'date': '09/09/2025',
      'amount': '2,200 XAF',
      'status': 'pending',
      'isSelected': true,
    },
    {
      'id': '3',
      'childName': 'Amara Fobi',
      'schoolName': 'Maarif School',
      'date': '09/09/2025',
      'amount': '8,200 XAF',
      'status': 'retry',
      'isSelected': true,
    },
  ];

  // Options pour les filtres
  final List<String> _childrenOptions = ['Amara Fobi', 'Jean-Baptiste Fobi'];
  final List<String> _schoolsOptions = ['Maarif School', 'Other School'];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _pageListener() {
    final page = _pageController.page?.round() ?? 0;
    if (page != currentIndex) {
      setState(() {
        currentIndex = page;
      });
    }
  }

  void _onSearchChanged() {
    setState(() {});
  }

  void _onSwitcherTap(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Méthode pour filtrer les transactions
  List<Map<String, dynamic>> get _filteredTransactions {
    List<Map<String, dynamic>> filtered = List.from(_allTransactions);

    // Filtre par recherche
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((transaction) {
        final searchTerm = _searchController.text.toLowerCase();
        return transaction['childName'].toLowerCase().contains(searchTerm) ||
            transaction['schoolName'].toLowerCase().contains(searchTerm) ||
            transaction['amount'].toLowerCase().contains(searchTerm) ||
            transaction['date'].contains(searchTerm);
      }).toList();
    }

    // Filtre par enfant
    if (_selectedChild != null) {
      filtered = filtered.where((transaction) {
        return transaction['childName'] == _selectedChild;
      }).toList();
    }

    // Filtre par école
    if (_selectedSchool != null) {
      filtered = filtered.where((transaction) {
        return transaction['schoolName'] == _selectedSchool;
      }).toList();
    }

    return filtered;
  }

  // Méthode pour effacer tous les filtres
  void _clearFilters() {
    setState(() {
      _selectedChild = null;
      _selectedSchool = null;
      _searchController.clear();
      _filterActive = false;
    });
  }

  // Vérifier s'il y a des filtres actifs
  bool get _hasActiveFilters {
    return _searchController.text.isNotEmpty ||
        _selectedChild != null ||
        _selectedSchool != null;
  }

  final List<Payment> _payments = [
    Payment(
      id: '1',
      title: 'Transport',
      amount: 50,
      receiver: 'Amara Fobi ',
      dueDate: DateTime.now(),
    ),

    Payment(
      id: '2',
      title: 'Transport',
      amount: 50,
      receiver: 'Amara Fobi ',
      dueDate: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(children: [_header(), SizedBox(height: 6), _body()]),
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
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  label: 'tuition.title'.tr(),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  label: 'tuition.desc'.tr(),
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: Container(
              width: 320,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _switcherButtons.map((button) {
                  final index = button['index'] as int;
                  final isActive = currentIndex == index;

                  return GestureDetector(
                    onTap: () => _onSwitcherTap(index),
                    child: Container(
                      height: 38,
                      width: 102.67,
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFFDEEBFF) : null,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: isActive ? 1 : 0,
                          color: isActive
                              ? const Color(0xFF0065FF)
                              : Colors.transparent,
                        ),
                      ),
                      child: Center(child: CustomText(label: button['label'])),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [_buildCurrentTuitionPage(), _buildHistoryPage(), _payment()],
      ),
    );
  }

  Widget _buildCurrentTuitionPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildStudentCard(
          studentName: 'Amara Fobi',
          totalDue: '12,500.00 XAF',
          pendingAmount: '4,200.00 XAF',
          schoolName: 'Maarif School',
        ),

        const SizedBox(height: 16),

        _buildStudentCard(
          studentName: 'Jean-Baptiste Fobi',
          totalDue: '12,500.00 XAF',
          pendingAmount: '12,500.00 XAF',
          schoolName: 'Maarif School',
        ),
      ],
    );
  }

  Widget _buildStudentCard({
    required String studentName,
    required String totalDue,
    required String pendingAmount,
    required String schoolName,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE1E4E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20),
              const SizedBox(width: 8),
              CustomText(
                label: studentName,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 23, vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFDEEBFF),
              border: Border.all(color: Color(0xFF0065FF)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label: 'global.totaldue'.tr(),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
                CustomText(
                  label: totalDue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                label: 'global.pending'.tr(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              CustomText(
                label: pendingAmount,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),

          Divider(thickness: 1, color: Color(0xFFE1E4E8)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                label: 'global.school'.tr(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              CustomText(
                label: schoolName,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),

          Divider(thickness: 1, color: Color(0xFFE1E4E8)),

          CustomButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => MethodpaymentScreen()),
              );
            },
            isDisabled: false,
            fullWidth: true,
            label: 'global.paynow'.tr(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryPage() {
    final filteredTransactions = _filteredTransactions;

    return Column(
      children: [
        // Barre de recherche et filtre
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'tuition.search_transactions'.tr(),
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.info,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFE1E4E8),
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFE1E4E8),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              InkWell(
                onTap: () {
                  setState(() {
                    _filterActive = !_filterActive;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _filterActive
                          ? const Color(0xFF0065FF)
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: _filterActive
                        ? const Color(0xFFDEEBFF)
                        : Colors.transparent,
                  ),
                  child: SvgPicture.asset("assets/images/31.svg"),
                ),
              ),
            ],
          ),
        ),

        // Filtres actifs
        if (_filterActive)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Column(
              children: [
                GridView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  children: [
                    MyPopupMenuButton(
                      label: _selectedChild ?? 'tuition.all_children'.tr(),
                      color: _selectedChild != null
                          ? const Color(0xFFDEEBFF)
                          : const Color(0xFFF7F8FA),
                      options: _childrenOptions,
                      onSelect: (value) {
                        setState(() {
                          _selectedChild = value;
                        });
                      },
                    ),
                    MyPopupMenuButton(
                      label: _selectedSchool ?? 'tuition.all_schools'.tr(),
                      color: _selectedSchool != null
                          ? const Color(0xFFDEEBFF)
                          : const Color(0xFFF7F8FA),
                      options: _schoolsOptions,
                      onSelect: (value) {
                        setState(() {
                          _selectedSchool = value;
                        });
                      },
                    ),
                  ],
                ),

                // Bouton pour effacer les filtres
                if (_hasActiveFilters) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _clearFilters,
                      child: CustomText(
                        label: 'global.clear_filters'.tr(),
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

        // Liste des transactions
        Expanded(
          child: filteredTransactions.isEmpty
              ? _buildEmptyState()
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ...filteredTransactions.map((transaction) {
                      return Column(
                        children: [
                          _buildTransactionItem(
                            childName: transaction['childName'],
                            schoolName: transaction['schoolName'],
                            date: transaction['date'],
                            amount: transaction['amount'],
                            isSelected: transaction['isSelected'],
                            status: transaction['status'],
                          ),
                          if (filteredTransactions.indexOf(transaction) !=
                              filteredTransactions.length - 1)
                            const SizedBox(height: 12),
                        ],
                      );
                    }),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            label: 'global.no_transactions'.tr(),
            fontSize: 16,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
          if (_hasActiveFilters)
            TextButton(
              onPressed: _clearFilters,
              child: CustomText(
                label: 'global.clear_filters'.tr(),
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String childName,
    required String schoolName,
    required String date,
    required String amount,
    required bool isSelected,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE1E4E8)),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                status == 'pending'
                    ? 'assets/images/51.svg'
                    : status == 'approved'
                    ? 'assets/images/53.svg'
                    : 'assets/images/52.svg',
              ),
              Container(height: 20),
            ],
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      label: childName,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),

                    CustomText(
                      label: date,
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      label: schoolName,
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),

                    CustomText(
                      label: amount,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: status == 'pending'
                          ? AppColors.warning
                          : status == 'approved'
                          ? AppColors.success
                          : AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _payment() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [..._payments.map((payment) => _paymentCard(payment))],
      ),
    );
  }

  Widget _paymentCard(Payment payment) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.backgroundSecondary,
        border: Border.all(color: Color(0xFFE1E4E8)),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomText(
                      label: payment.title,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),

                    CustomText(
                      label: payment.receiver,
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Wrap(
                      children: [
                        CustomText(
                          label: payment.amount.toString(),
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          fontSize: 16,
                        ),

                        CustomText(
                          label: 'XAF',
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ],
                    ),

                    CustomText(
                      label:
                          '${payment.dueDate.month.toString()}, ${payment.dueDate.day.toString()}',
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'global.paynow'.tr(),
                    
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => MethodpaymentScreen(),
                        ),
                      );
                    },
                  ),
                ),

                Expanded(
                  child: CustomButton(
                    label: 'global.setreminder'.tr(),
                    textColor: Color(0xFF6A737D),
                    border: Border.all(width: 1, color: Color(0xFFE1E4E8)),
                    color: Colors.transparent,
                    onPressed: () {
                      showSetReminderModal(context: context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
