import 'package:c1_hsch/features/onboarding/presentation/widgets/animated_content_body.dart';
import 'package:c1_hsch/features/onboarding/presentation/widgets/branding_header.dart';
import 'package:c1_hsch/features/onboarding/presentation/widgets/footer_actions.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// الشاشة الرئيسية للإنترو
class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      BrandingHeader(), // شعار التطبيق العلوي
                      AnimatedContentBody(), // القسم الأوسط المتحرك (الصورة والنصوص)
                      FooterActions(), // زر البدء ورقم الإصدار بالأسفل
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




/// 3. زر الحفظ والبدء وتوقيع رقم الإصدار بالأسفل (Footer Actions)

