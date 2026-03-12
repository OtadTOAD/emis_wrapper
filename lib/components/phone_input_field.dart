import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String selectedCountryCode;
  final List<Map<String, String>> countryCodes;
  final ValueChanged<String> onCountryCodeChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    required this.selectedCountryCode,
    required this.countryCodes,
    required this.onCountryCodeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone Number',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 13,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C24),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2D2D3A), width: 1.5),
          ),
          child: Row(
            children: [
              // Country code picker
              GestureDetector(
                onTap: () => _showCountryPicker(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 18,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color(0xFF2D2D3A), width: 1.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        countryCodes.firstWhere(
                          (c) => c['code'] == selectedCountryCode,
                          orElse: () => countryCodes.first,
                        )['flag']!,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        selectedCountryCode,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.expand_more_rounded,
                        color: Color(0xFF6B7280),
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),

              // Phone number input
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: '000 000 0000',
                    hintStyle: TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C1C24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF374151),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Country Code',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...countryCodes.map(
            (country) => ListTile(
              leading: Text(
                country['flag']!,
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(
                '${country['name']} (${country['code']})',
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              trailing: selectedCountryCode == country['code']
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF6366F1),
                    )
                  : null,
              onTap: () {
                onCountryCodeChanged(country['code']!);
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
