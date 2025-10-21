import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hemle/components/custom_back_appbar.dart';
import 'package:hemle/components/custom_text.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/config/colors/appSizes.dart';
import 'package:hemle/features/findschool/presentation/widgets/MyPopupMenuButton.dart';
import 'package:hemle/features/findschool/presentation/screens/schoolprofile_screen.dart';
import 'package:hemle/features/home/data/models/home_models.dart';
import 'package:hemle/utils/number_formater.dart';

class FindschoolScreen extends StatefulWidget {
  const FindschoolScreen({super.key});

  @override
  State<FindschoolScreen> createState() => _FindschoolScreenState();
}

class _FindschoolScreenState extends State<FindschoolScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedType;
  String? _selectedStatus;
  bool _filterActive = false;
  String selectedDisposition = 'listview';

  final List<String> _filterOptions = [
    'findschool.nursery'.tr(),
    'findschool.primary'.tr(),
    'findschool.secondary'.tr(),
  ];

  final List<String> _filterStatus = [
    'findschool.private'.tr(),
    'findschool.public'.tr(),
  ];

  final List<School> _allSchools = [
    School(
      id: '1',
      name: 'Starfield Academy',
      location: 'Ngaoundéré',
      type: 'Secondary',
      amount: 2000,
      status: 'private',
      email: 'cm@turkiyemaarif.org',
      tel: '+237 222 211 204',
      reviews: 4,
      website: 'cm.maarifschools.org',
      accreditation: 'Cambridge International Programme',
      affiliation: 'Turkish Maarif Foundation',
    ),
    School(
      id: '2',
      name: 'Green Valley School',
      location: 'Rue 1891, 124 Dragages Bastos, Yaoundé',
      type: 'Primary',
      reviews: 3,
      amount: 1500,
      email: 'cm@turkiyemaarif.org',
      tel: '+237 222 211 204',
      website: 'cm.maarifschools.org',
      accreditation: 'Cambridge International Programme',
      status: 'public',
      affiliation: 'Turkish Maarif Foundation',
    ),
    School(
      id: '3',
      name: 'Little Stars Nursery',
      location: 'Douala',
      type: 'Nursery',
      amount: 1000,
      reviews: 4,
      email: 'cm@turkiyemaarif.org',
      tel: '+237 222 211 204',
      website: 'cm.maarifschools.org',
      status: 'private',
    ),
    School(
      id: '4',
      name: 'Excel High School',
      location: 'Rue 1891, 124 Dragages Bastos, Yaoundé',
      type: 'Secondary',
      accreditation: 'Cambridge International Programme',
      amount: 2500,
      reviews: 5,
      status: 'private',
    ),
    School(
      id: '5',
      name: 'Community Primary',
      location: 'Garoua',
      type: 'Primary',
      reviews: 1.5,
      amount: 1200,
      status: 'public',
      affiliation: 'Turkish Maarif Foundation',
    ),
  ];

  List<School> get _filteredSchools {
    List<School> filtered = _allSchools;

    // Filtre par recherche
    if (_searchController.text.isNotEmpty) {
      filtered = filtered
          .where(
            (school) =>
                school.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ) ||
                school.location!.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ),
          )
          .toList();
    }

    // Filtre par type
    if (_selectedType != null) {
      filtered = filtered.where((school) {
        // Comparer avec les valeurs originales des types d'école
        if (_selectedType == 'findschool.nursery'.tr()) {
          return school.type == 'Nursery';
        } else if (_selectedType == 'findschool.primary'.tr()) {
          return school.type == 'Primary';
        } else if (_selectedType == 'findschool.secondary'.tr()) {
          return school.type == 'Secondary';
        }
        return true;
      }).toList();
    }

    // Filtre par statut
    if (_selectedStatus != null) {
      filtered = filtered.where((school) {
        // Comparer avec les valeurs originales des statuts
        if (_selectedStatus == 'findschool.private'.tr()) {
          return school.status == 'private';
        } else if (_selectedStatus == 'findschool.public'.tr()) {
          return school.status == 'public';
        }
        return true;
      }).toList();
    }

    return filtered;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  void _clearFilters() {
    setState(() {
      _selectedType = null;
      _selectedStatus = null;
      _searchController.clear();
    });
  }

  bool get _hasActiveFilters {
    return _searchController.text.isNotEmpty ||
        _selectedType != null ||
        _selectedStatus != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomBackAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_header(), _resultsDispose(), _schoolList()],
      ),
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
            label: 'findschool.title'.tr(),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'findschool.searchschool'.tr(),
                      hintStyle: TextStyle(
                        fontFamily: 'inter',
                        color: Colors.grey.shade600,
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
                    controller: _searchController,
                    onChanged: (value) => setState(() {}),
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
                  child: Center(child: SvgPicture.asset("assets/images/31.svg", color: _filterActive ? AppColors.primary : null,)),
                ),
              ),
            ],
          ),

          if (_filterActive) const SizedBox(height: 18),

          if (_filterActive)
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
                  label: 'findschool.allcities'.tr(),
                  color: const Color(0xFFF7F8FA),
                  options: [],
                  onSelect: (value) {
                    setState(() {});
                  },
                ),
                MyPopupMenuButton(
                  label: _selectedType ?? 'findschool.alltypes'.tr(),
                  options: _filterOptions,
                  color: _selectedType != null
                      ? const Color(0xFFDEEBFF)
                      : const Color(0xFFF7F8FA),
                  onSelect: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                ),
                MyPopupMenuButton(
                  label: _selectedStatus ?? 'findschool.allstatus'.tr(),
                  options: _filterStatus,
                  color: _selectedStatus != null
                      ? const Color(0xFFDEEBFF)
                      : const Color(0xFFF7F8FA),
                  onSelect: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
                MyPopupMenuButton(
                  label: 'findschool.allranges'.tr(),
                  options: [],
                  color: const Color(0xFFF7F8FA),
                  onSelect: (value) {
                    setState(() {});
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _resultsDispose() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            label: 'findschool.resultslength'.tr(
              args: [_filteredSchools.length.toString()],
            ),
            fontSize: 14,
            color: const Color(0xFF6A737D),
          ),
          Container(
            width: 82,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: const Color(0xFFE1E4E8)),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedDisposition = 'listview';
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: selectedDisposition == 'listview'
                          ? const Color(0xFFDEEBFF)
                          : null,
                      border: Border.all(
                        color: selectedDisposition == 'listview'
                            ? const Color(0xFF0065FF)
                            : Colors.transparent,
                      ),
                    ),
                    child:  Center(child: SvgPicture.asset('assets/images/33.svg', color: selectedDisposition == 'listview' ? AppColors.primary : null,))
                  ),
                ),

                InkWell(
                  onTap: () {
                    setState(() {
                      selectedDisposition = 'gridview';
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: selectedDisposition == 'gridview'
                          ? const Color(0xFFDEEBFF)
                          : null,
                      border: Border.all(
                        color: selectedDisposition == 'gridview'
                            ? const Color(0xFF0065FF)
                            : Colors.transparent,
                      ),
                    ),
                    child: Center(child: SvgPicture.asset('assets/images/34.svg', color: selectedDisposition == 'gridview' ? AppColors.primary : null,))
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _schoolList() {
    final schools = _filteredSchools;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: schools.isEmpty
            ? _buildEmptyState()
            : selectedDisposition == 'listview'
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: schools.length,
                itemBuilder: (context, index) {
                  final school = schools[index];
                  return listviewCard(school);
                },
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 8,
                ),
                itemCount: schools.length,
                itemBuilder: (context, index) {
                  final school = schools[index];
                  return gridviewCard(school);
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset('assets/images/empty_search.png', height: 120),
          // const SizedBox(height: 16),
          CustomText(
            label: 'findschool.noresults'.tr(),
            fontSize: 16,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
          if (_hasActiveFilters)
            TextButton(
              onPressed: _clearFilters,
              child: CustomText(
                label: 'findschool.clearfilters'.tr(),
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }

  Widget listviewCard(School school) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => SchoolProfileScreen(school: school),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shadowColor: AppColors.gray.withOpacity(.2),
        color: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Logo de l'école
              SizedBox(
                width: (AppSizes.screenWidth(context) - 32) / 4,
                height: 50,
                child: const CircleAvatar(radius: 50),
              ),

              const SizedBox(width: 12),

              // Informations de l'école
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: school.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/28.svg'),
                            const SizedBox(width: 4),
                            Container(
                              constraints: BoxConstraints(maxWidth: 100),
                              child: CustomText(
                                label: school.location ?? '',
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 10),

                        Row(
                          children: [
                            SvgPicture.asset('assets/images/29.svg'),
                            const SizedBox(width: 4),
                            CustomText(
                              label: school.type ?? '',
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Prix
                    Row(
                      children: [
                        CustomText(
                          label: NumberFormatter.formatPrice(
                            school.amount,
                            locale: 'fr',
                          ),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: const Color(0xFF22A06B),
                        ),
                        const SizedBox(width: 4),
                        CustomText(
                          label: 'findschool.priceperyear'.tr(),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: const Color(0xFF22A06B),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget gridviewCard(School school) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => SchoolProfileScreen(school: school),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shadowColor: AppColors.gray.withOpacity(.2),
        color: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(radius: 30),

              const Spacer(),

              CustomText(
                label: school.name,
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
              ),

              const SizedBox(height: 8),

              Column(
                children: [
                  Row(
                    children: [
                     SvgPicture.asset('assets/images/28.svg'),
                      const SizedBox(width: 4),
                      Expanded(
                        child: CustomText(
                          label: school.location ?? '',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      SvgPicture.asset('assets/images/29.svg'),
                      const SizedBox(width: 4),
                      Expanded(
                        child: CustomText(
                          label: school.type ?? '',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Prix
              Row(
                children: [
                  CustomText(
                    label: NumberFormatter.formatNumber(
                      school.amount,
                      locale: 'fr',
                    ),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color(0xFF22A06B),
                  ),
                  const SizedBox(width: 4),
                  CustomText(
                    label: 'findschool.priceperyear'.tr(),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color(0xFF22A06B),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
