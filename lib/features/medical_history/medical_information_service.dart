import 'dart:convert';

import 'package:http/http.dart' as http;

class MedicalInformationService {

    Future<String?> getInformation(String icd10Code) async {

        final uri = Uri.https(
            'connect.medlineplus.gov',
            '/service',
            {
                'mainSearchCriteria.v.cs': '2.16.840.1.113883.6.90',
                'mainSearchCriteria.v.c': icd10Code,
                'informationRecipient.languageCode.c': 'en',
                'knowledgeResponseType': 'application/json',
            },
        );

        try {

            final response = await http.get(uri);

            if (response.statusCode != 200) {
                return null;
            }

            final data = jsonDecode(response.body);

            final entries = data['feed']?['entry'];

            if (entries is! List || entries.isEmpty) {
                return null;
            }

            final entry = entries.first;

            final summary = entry['summary']; 

            if (summary is Map) {
                final value = summary['_value'];

                if (value is String) {
                    return _cleanHtml(value); 
                }
            }

            if (summary is String) {
                return _cleanHtml(summary); 
            }
            
            return null; 

        } catch (_) {

            return null;

        }
    }


    String _cleanHtml(String html) {

        var text = html;

        // Add line breaks before removing HTML tags.
        text = text.replaceAll(
            RegExp(r'</h[1-6]>'),
            '\n\n',
        );

        text = text.replaceAll(
            RegExp(r'</p>'),
            '\n\n',
        );

        text = text.replaceAll(
            RegExp(r'</li>'),
            '\n',
        );

        text = text.replaceAll(
            RegExp(r'<li[^>]*>'),
            '• ',
        );

        // Remove remaining HTML tags.
        text = text.replaceAll(
            RegExp(r'<[^>]*>'),
            '',
        );

        // Decode common HTML entities.
        text = text
            .replaceAll('&amp;', '&')
            .replaceAll('&lt;', '<')
            .replaceAll('&gt;', '>')
            .replaceAll('&quot;', '"')
            .replaceAll('&#39;', "'")
            .replaceAll('&nbsp;', ' ');

        // Normalize excessive whitespace.
        text = text.replaceAll(
            RegExp(r'[ \t]+'),
            ' ',
        );

        text = text.replaceAll(
            RegExp(r'\n\s*\n\s*\n+'),
            '\n\n',
        );

        return text.trim();
    }

}    