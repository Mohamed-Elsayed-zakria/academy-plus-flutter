import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../constants/app_colors.dart';

class Country {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  const Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });
}

class CustomPhoneInput extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? initialCountryCode;
  final Function(String countryCode, String dialCode)? onCountryChanged;

  const CustomPhoneInput({
    super.key,
    this.hintText = 'Phone Number',
    this.controller,
    this.validator,
    this.initialCountryCode,
    this.onCountryChanged,
  });

  @override
  State<CustomPhoneInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {
  Country? _selectedCountry;
  final List<Country> _countries = [
    const Country(name: 'Egypt', code: 'EG', dialCode: '+20', flag: '🇪🇬'),
    const Country(name: 'United States', code: 'US', dialCode: '+1', flag: '🇺🇸'),
    const Country(name: 'United Kingdom', code: 'GB', dialCode: '+44', flag: '🇬🇧'),
    const Country(name: 'Saudi Arabia', code: 'SA', dialCode: '+966', flag: '🇸🇦'),
    const Country(name: 'United Arab Emirates', code: 'AE', dialCode: '+971', flag: '🇦🇪'),
    const Country(name: 'Jordan', code: 'JO', dialCode: '+962', flag: '🇯🇴'),
    const Country(name: 'Lebanon', code: 'LB', dialCode: '+961', flag: '🇱🇧'),
    const Country(name: 'Kuwait', code: 'KW', dialCode: '+965', flag: '🇰🇼'),
    const Country(name: 'Qatar', code: 'QA', dialCode: '+974', flag: '🇶🇦'),
    const Country(name: 'Bahrain', code: 'BH', dialCode: '+973', flag: '🇧🇭'),
    const Country(name: 'Oman', code: 'OM', dialCode: '+968', flag: '🇴🇲'),
    const Country(name: 'Iraq', code: 'IQ', dialCode: '+964', flag: '🇮🇶'),
    const Country(name: 'Syria', code: 'SY', dialCode: '+963', flag: '🇸🇾'),
    const Country(name: 'Turkey', code: 'TR', dialCode: '+90', flag: '🇹🇷'),
    const Country(name: 'Iran', code: 'IR', dialCode: '+98', flag: '🇮🇷'),
    const Country(name: 'India', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
    const Country(name: 'Pakistan', code: 'PK', dialCode: '+92', flag: '🇵🇰'),
    const Country(name: 'Bangladesh', code: 'BD', dialCode: '+880', flag: '🇧🇩'),
    const Country(name: 'Afghanistan', code: 'AF', dialCode: '+93', flag: '🇦🇫'),
    const Country(name: 'Canada', code: 'CA', dialCode: '+1', flag: '🇨🇦'),
    const Country(name: 'Australia', code: 'AU', dialCode: '+61', flag: '🇦🇺'),
    const Country(name: 'Germany', code: 'DE', dialCode: '+49', flag: '🇩🇪'),
    const Country(name: 'France', code: 'FR', dialCode: '+33', flag: '🇫🇷'),
    const Country(name: 'Italy', code: 'IT', dialCode: '+39', flag: '🇮🇹'),
    const Country(name: 'Spain', code: 'ES', dialCode: '+34', flag: '🇪🇸'),
    const Country(name: 'Netherlands', code: 'NL', dialCode: '+31', flag: '🇳🇱'),
    const Country(name: 'Belgium', code: 'BE', dialCode: '+32', flag: '🇧🇪'),
    const Country(name: 'Switzerland', code: 'CH', dialCode: '+41', flag: '🇨🇭'),
    const Country(name: 'Austria', code: 'AT', dialCode: '+43', flag: '🇦🇹'),
    const Country(name: 'Sweden', code: 'SE', dialCode: '+46', flag: '🇸🇪'),
    const Country(name: 'Norway', code: 'NO', dialCode: '+47', flag: '🇳🇴'),
    const Country(name: 'Denmark', code: 'DK', dialCode: '+45', flag: '🇩🇰'),
    const Country(name: 'Finland', code: 'FI', dialCode: '+358', flag: '🇫🇮'),
    const Country(name: 'Poland', code: 'PL', dialCode: '+48', flag: '🇵🇱'),
    const Country(name: 'Czech Republic', code: 'CZ', dialCode: '+420', flag: '🇨🇿'),
    const Country(name: 'Hungary', code: 'HU', dialCode: '+36', flag: '🇭🇺'),
    const Country(name: 'Romania', code: 'RO', dialCode: '+40', flag: '🇷🇴'),
    const Country(name: 'Bulgaria', code: 'BG', dialCode: '+359', flag: '🇧🇬'),
    const Country(name: 'Greece', code: 'GR', dialCode: '+30', flag: '🇬🇷'),
    const Country(name: 'Portugal', code: 'PT', dialCode: '+351', flag: '🇵🇹'),
    const Country(name: 'Russia', code: 'RU', dialCode: '+7', flag: '🇷🇺'),
    const Country(name: 'China', code: 'CN', dialCode: '+86', flag: '🇨🇳'),
    const Country(name: 'Japan', code: 'JP', dialCode: '+81', flag: '🇯🇵'),
    const Country(name: 'South Korea', code: 'KR', dialCode: '+82', flag: '🇰🇷'),
    const Country(name: 'Thailand', code: 'TH', dialCode: '+66', flag: '🇹🇭'),
    const Country(name: 'Vietnam', code: 'VN', dialCode: '+84', flag: '🇻🇳'),
    const Country(name: 'Malaysia', code: 'MY', dialCode: '+60', flag: '🇲🇾'),
    const Country(name: 'Singapore', code: 'SG', dialCode: '+65', flag: '🇸🇬'),
    const Country(name: 'Indonesia', code: 'ID', dialCode: '+62', flag: '🇮🇩'),
    const Country(name: 'Philippines', code: 'PH', dialCode: '+63', flag: '🇵🇭'),
    const Country(name: 'Brazil', code: 'BR', dialCode: '+55', flag: '🇧🇷'),
    const Country(name: 'Argentina', code: 'AR', dialCode: '+54', flag: '🇦🇷'),
    const Country(name: 'Chile', code: 'CL', dialCode: '+56', flag: '🇨🇱'),
    const Country(name: 'Mexico', code: 'MX', dialCode: '+52', flag: '🇲🇽'),
    const Country(name: 'South Africa', code: 'ZA', dialCode: '+27', flag: '🇿🇦'),
    const Country(name: 'Nigeria', code: 'NG', dialCode: '+234', flag: '🇳🇬'),
    const Country(name: 'Kenya', code: 'KE', dialCode: '+254', flag: '🇰🇪'),
    const Country(name: 'Morocco', code: 'MA', dialCode: '+212', flag: '🇲🇦'),
    const Country(name: 'Algeria', code: 'DZ', dialCode: '+213', flag: '🇩🇿'),
    const Country(name: 'Tunisia', code: 'TN', dialCode: '+216', flag: '🇹🇳'),
    const Country(name: 'Libya', code: 'LY', dialCode: '+218', flag: '🇱🇾'),
    const Country(name: 'Sudan', code: 'SD', dialCode: '+249', flag: '🇸🇩'),
    const Country(name: 'Ethiopia', code: 'ET', dialCode: '+251', flag: '🇪🇹'),
  ];

  @override
  void initState() {
    super.initState();
    // Set default country based on initialCountryCode or default to Egypt
    _selectedCountry = _countries.firstWhere(
      (country) => country.code == (widget.initialCountryCode ?? 'EG'),
      orElse: () => _countries.first,
    );
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CountryPickerBottomSheet(
        countries: _countries,
        selectedCountry: _selectedCountry!,
        onCountrySelected: (country) {
          setState(() {
            _selectedCountry = country;
          });
          widget.onCountryChanged?.call(country.code, country.dialCode);
          Navigator.pop(context);
        },
      ),
    );
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Remove any non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    // Basic validation - at least 7 digits, maximum 15 digits
    if (digitsOnly.length < 7) {
      return 'Please enter a valid phone number';
    }
    
    if (digitsOnly.length > 15) {
      return 'Phone number is too long';
    }

    // Call custom validator if provided
    return widget.validator?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceGrey),
      ),
      child: Row(
        children: [
          // Country Code Selector
          GestureDetector(
            onTap: _showCountryPicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                border: Border(
                  right: BorderSide(color: AppColors.surfaceGrey),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedCountry?.flag ?? '🇪🇬',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _selectedCountry?.dialCode ?? '+20',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Ionicons.chevron_down_outline,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          
          // Phone Number Input
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.phone,
              validator: _validatePhoneNumber,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                prefixIcon: const Icon(
                  Ionicons.call_outline,
                  color: AppColors.textSecondary,
                ),
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryPickerBottomSheet extends StatefulWidget {
  final List<Country> countries;
  final Country selectedCountry;
  final Function(Country) onCountrySelected;

  const _CountryPickerBottomSheet({
    required this.countries,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  State<_CountryPickerBottomSheet> createState() => _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<_CountryPickerBottomSheet> {
  late List<Country> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = widget.countries;
      } else {
        _filteredCountries = widget.countries.where((country) {
          return country.name.toLowerCase().contains(query.toLowerCase()) ||
                 country.dialCode.contains(query) ||
                 country.code.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textTertiary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  'Select Country',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Ionicons.close_outline,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCountries,
              decoration: InputDecoration(
                hintText: 'Search countries...',
                prefixIcon: Icon(
                  Ionicons.search_outline,
                  color: AppColors.textSecondary,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _filterCountries('');
                        },
                        child: Icon(
                          Ionicons.close_circle_outline,
                          color: AppColors.textSecondary,
                        ),
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.surfaceGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.surfaceGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Countries list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final isSelected = country.code == widget.selectedCountry.code;
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected 
                        ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
                        : null,
                  ),
                  child: ListTile(
                    onTap: () => widget.onCountrySelected(country),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Text(
                      country.flag,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(
                      country.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                          ),
                    ),
                    subtitle: Text(
                      country.dialCode,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isSelected ? AppColors.primary : AppColors.textSecondary,
                          ),
                    ),
                    trailing: isSelected
                        ? Icon(
                            Ionicons.checkmark_circle_outline,
                            color: AppColors.primary,
                            size: 20,
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
