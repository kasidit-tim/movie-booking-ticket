abstract class ApiEndpoints {
  // Movies
  static const String nowPlaying = '/3/movie/now_playing';
  static String movieDetailById(int id) => '/3/movie/$id';
  static String movieVideosById(int id) => '/3/movie/$id/videos';
  static String movieCreditsById(int id) => '/3/movie/$id/credits';
  static const String comingSoon = '/3/discover/movie';
}
