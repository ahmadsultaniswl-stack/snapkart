import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import 'address_controller.dart';
import 'map_picker_view.dart';

class AddAddressView extends StatelessWidget {
  AddAddressView({super.key});

  final AddAddressController controller = Get.put(AddAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.isEditMode.value
                ? 'address_edit_title'.tr
                : 'address_add_title'.tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary(context),
            ),
          ),
        ),
        backgroundColor: AppColors.cardBackground(context),
        foregroundColor: AppColors.textPrimary(context),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Form Card ──
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground(context),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildField(
                    context: context,
                    controller: controller.nameController,
                    label: 'your_name'.tr,
                    hint: 'e.g. Ahmad Sultan',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    context: context,
                    controller: controller.phoneController,
                    label: 'phone_number'.tr,
                    hint: 'e.g. 03001234567',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    context: context,
                    controller: controller.streetController,
                    label: 'street'.tr,
                    hint: 'e.g. House 12, Street 5, Gulberg',
                    icon: Icons.home_outlined,
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    context: context,
                    controller: controller.cityController,
                    label: 'city'.tr,
                    hint: 'e.g. Lahore',
                    icon: Icons.location_city_outlined,
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    context: context,
                    controller: controller.provinceController,
                    label: 'province'.tr,
                    hint: 'e.g. Punjab',
                    icon: Icons.map_outlined,
                  ),

                  const SizedBox(height: 16),
                  _buildField(
                    context: context,
                    controller: controller.provinceController,
                    label: 'province'.tr,
                    hint: 'e.g. Punjab',
                    icon: Icons.map_outlined,
                  ),
                  const SizedBox(height: 16),

                  // NEW: Pick on Map button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final result = await Get.to(
                          () => const MapPickerView(),
                        );
                        if (result != null) {
                          controller.setPickedLocation(
                            result['lat'],
                            result['lng'],
                            result['address'],
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF6C63FF),
                      ),
                      label: Text(
                        'pick_on_map'.tr,
                        style: const TextStyle(
                          color: Color(0xFF6C63FF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF6C63FF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // ── Save Button ──
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: controller.isSaving.value
                      ? null
                      : controller.saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: controller.isSaving.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          controller.isEditMode.value
                              ? 'address_update_btn'.tr
                              : 'address_save_btn'.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: AppColors.textPrimary(context)),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF6C63FF)),
        filled: true,
        fillColor: AppColors.background(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 1.5),
        ),
        labelStyle: TextStyle(color: AppColors.textSecondary(context)),
      ),
    );
  }
}
