abstract class AppUrls {
  static const String baseUrl =
      'https://nixlab-social-api.herokuapp.com/api/v1';

//  Endpoints
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';
  static const String updatePasswordEndpoint = '/update/password';
  static const String forgotPasswordEndpoint = '/forgot/password';
  static const String resetPasswordEndpoint = '/reset/password';
  static const String profileDetailsEndpoint = '/me';
  static const String getAllPostsEndpoint = '/admin/posts';
  static const String getFollowingPostsEndpoint = '/posts';
  static const String createPostEndpoint = '/post/create';
  static const String likePostEndpoint = '/post/like';

  static const String uploadProfilePicEndpoint = '/avatar/me';
  static const String updateProfileDetailsEndpoint = '/update/me';
  static const String checkUsernameAvailableEndpoint = '/check/username';
  static const String updateUsernameEndpoint = '/update/username';
  static const String followUserEndpoint = '/follow';
  static const String getUsersEndpoint = '/users';
  static const String userDetailsEndpoint = '/user';
}
