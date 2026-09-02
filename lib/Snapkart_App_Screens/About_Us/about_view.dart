import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import 'about_cont.dart';

class AboutView extends GetView<AboutController> {
  AboutView({super.key});
  final controller = Get.put(AboutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary(context)),
        centerTitle: true,
        title: Text(
          'about_us'.tr,
          style: TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: 1,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // Animated Logo Section
            _buildAnimatedLogo(),

            const SizedBox(height: 20),

            // App Name Card
            _buildInfoCard(
              context: context,
              icon: Icons.phone_android_outlined,
              title: 'app_name'.tr,
              value: controller.appName.value,
              iconColor: AppColors.secondary,
            ),

            const SizedBox(height: 16),

            // Description Card
            _buildDescriptionCard(context, 'app_description'.tr),

            const SizedBox(height: 16),

            // Developer Card
            _buildInfoCard(
              context: context,
              icon: Icons.people_alt_outlined,
              title: 'developed_by'.tr,
              value: controller.developer.value,
              iconColor: AppColors.secondary,
            ),

            const SizedBox(height: 16),

            // Version Card
            _buildInfoCard(
              context: context,
              icon: Icons.label_important_outline,
              title: 'app_version'.tr,
              value: controller.version.value,
              iconColor: AppColors.secondary,
            ),

            const SizedBox(height: 16),

            // Contact Card with Action
            _buildContactCard(
              context: context,
              icon: Icons.email_outlined,
              title: 'contact_us'.tr,
              value: controller.email.value,
              iconColor: AppColors.secondary,
              onTap: () => controller.sendEmail(),
            ),

            const SizedBox(height: 16),

            // Social Links Section
            _buildSocialLinks(context),

            const SizedBox(height: 16),

            // Complaint Box Section
            _buildComplaintBox(context),

            const SizedBox(height: 30),

            // Copyright Text
            _buildCopyright(context),
          ],
        ),
      ),
    );
  }

  BoxDecoration _glassDecoration(BuildContext context, {double radius = 20}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      gradient: isDark
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            )
          : null,
      color: isDark ? null : AppColors.cardBackground(context),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.06),
      ),
      boxShadow: isDark
          ? null
          : [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
    );
  }

  Widget _buildAnimatedLogo() {
    return Container(
      height: 220,
      width: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withOpacity(0.3),
            AppColors.secondary.withOpacity(0.1),
          ],
        ),
      ),
      child: Lottie.asset("assets/animation/team.json", fit: BoxFit.contain),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: _glassDecoration(context),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textSecondary(context),
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: AppColors.textPrimary(context),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context, String description) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _glassDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: AppColors.secondary,
                size: 24,
              ),
              const SizedBox(width: 10),
              Text(
                'about_app'.tr,
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              color: AppColors.textSecondary(context),
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: _glassDecoration(context),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textSecondary(context),
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      color: AppColors.textPrimary(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.secondary, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: _glassDecoration(context),
      child: Column(
        children: [
          Text(
            'connect_with_us'.tr,
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.facebook, () => controller.openFacebook()),
              const SizedBox(width: 34),
              _buildSocialIcon(Icons.link, () => controller.openLinkedIn()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.2),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.secondary),
        ),
        child: Icon(icon, color: AppColors.secondary, size: 24),
      ),
    );
  }

  Widget _buildComplaintBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _glassDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.report_problem_outlined,
                color: AppColors.secondary,
                size: 24,
              ),
              const SizedBox(width: 10),
              Text(
                'complaint_box'.tr,
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller.complaintController,
            maxLines: 4,
            style: TextStyle(color: AppColors.textPrimary(context)),
            decoration: InputDecoration(
              hintText: 'write_your_complaint_here'.tr,
              hintStyle: TextStyle(color: AppColors.textSecondary(context)),
              filled: true,
              fillColor: AppColors.background(context),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 14),
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isSubmitting.value
                    ? null
                    : controller.submitComplaint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: controller.isSubmitting.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'submit_complaint'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCopyright(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Divider(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.08),
          thickness: 1,
        ),
        const SizedBox(height: 10),
        Text(
          "© ${DateTime.now().year} SnapKart App. All rights reserved.",
          style: TextStyle(
            color: AppColors.textSecondary(context),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
