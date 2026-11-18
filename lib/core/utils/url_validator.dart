class UrlValidator {
  static String? validate(String? url) {
    {
      if (url == null || url.isEmpty) return "Enter URL";
      final uri = Uri.tryParse(url);
      if (uri == null || !(uri.scheme == 'http' || uri.scheme == 'https')) {
        return "Enter valid URL";
      }
      return null;
    }
  }
}
