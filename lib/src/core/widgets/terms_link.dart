import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsLink extends StatelessWidget {
  const TermsLink({super.key});

  static const _termsUrl =
      'https://eduardoazevedo.com/stackbudget/termsAndPolicy';

  Future<void> _launchTermsUrl() async {
    final uri = Uri.parse(_termsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $_termsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _launchTermsUrl,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
      ),
      child: Text(
        context.strings.termsAndPrivacy,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.primary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
