class AppStrings {
  static const appName = 'Flutter News Feed';
  static const newsApiKey = '25fe9819ace84c86b36a91edba5aa3d4'; // <-- INSERT YOUR KEY HERE
  static const newsApiBaseUrl = 'https://newsapi.org/v2';
  static const defaultQuery = 'flutter';
  static const noInternet = 'No Internet Connection';
  static const timeoutError = 'Request Timed Out';
  static const generalError = 'Something went wrong. Please try again.';
  static const emptyNews = 'No news found for your query.';
  static const bookmarks = 'Bookmarks';
  static const settings = 'Settings';
  static const searchHistory = 'Search History';
  static const clear = 'Clear';
  static const offline = 'You are offline';
  static const retry = 'Retry';
  static const share = 'Share';
  static const bookmarkAdded = 'Article bookmarked!';
  static const bookmarkRemoved = 'Bookmark removed!';
  static const lightTheme = 'Light';
  static const darkTheme = 'Dark';
  static const systemTheme = 'System';
  static const articlesPerPage = 20;
  static const cacheExpiryMinutes = 15;
}

class AppStorageKeys {
  static const cachedArticles = 'cached_articles';
  static const cachedAt = 'cached_at';
  static const bookmarks = 'bookmarks';
  static const searchHistory = 'search_history';
  static const themeMode = 'theme_mode';
}