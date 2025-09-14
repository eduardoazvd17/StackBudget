import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsLinkTile extends StatelessWidget {
  const TermsLinkTile({super.key});

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
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        Icons.description_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(context.strings.termsAndPrivacy),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: _launchTermsUrl,
    );
  }
}
