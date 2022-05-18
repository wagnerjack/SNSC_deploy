class ApiConfig {
  //static const String rootURL = 'localhost:9090'; //ROOT_URL for iOS and web
  //static const String rootURL = '10.0.2.2:9090'; //ROOT_URL for android
  static const String rootURL = 'snsc-api.herokuapp.com';
  // user functions
  static const String loginAPI = '/api/login';
  static const String signupAPI = '/api/signup';
  static const String userAPI = '/api/user';
  static const String allUsersAPI = '/api/users';
  static const String userFavoritesAPI = '/api/user/favorites';
  static const String userpasswordAPI = '/api/user/password';

  // organization functions
  static const String organizationsAPI = '/api/organizations';
  static const String textSearch = '/api/autocomplete/organizations';
  static const String filterSearch = '/api/search/organizations';

  // filter functions
  static const String filterAPI = '/api/filters';
  static const String faqAPI = '/api/faq';

  // image functions
  static const String herokuUploads =
      'http://snsc-api.herokuapp.com/api/images';
  static const String localUploads = 'http://localhost:9090/api/images';
}
