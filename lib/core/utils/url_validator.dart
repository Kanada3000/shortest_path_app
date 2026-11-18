class UrlValidator {
  static String? validate(String? url) {
    {
      if (url == null || url.trim().isEmpty) return "Enter URL";
      final uri = Uri.tryParse(url.trim());
      if (uri == null ||
          !(uri.scheme == 'http' || uri.scheme == 'https') ||
          uri.host.isEmpty) {
        return "Enter valid URL";
      }
      return null;
    }
  }
}
