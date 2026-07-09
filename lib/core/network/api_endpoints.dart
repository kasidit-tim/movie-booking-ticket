abstract class ApiEndpoints {
  // Movies
  static const String nowPlaying = '/3/movie/now_playing';
  static String movieDetailById(int id) => '/3/movie/$id';
}
