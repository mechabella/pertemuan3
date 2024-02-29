import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();

  List<Movie> _allMovies = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];

  Future<void> _loadMovies() async {
    final List<Map<String, dynamic>> allMoviesData =
        await _apiServices.getAllMovies();
    final List<Map<String, dynamic>> trendingMoviesData =
        await _apiServices.getTrendingMovies();
    final List<Map<String, dynamic>> popularMoviesData =
        await _apiServices.getPopularMovies();
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilem'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMoviesList('All Movies', _allMovies),
            _buildMoviesList('Trending Movies', _trendingMovies),
            _buildMoviesList('Popular Movies', _popularMovies)
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesList(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final Movie movie = movies[index];
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        '${movie.posterPath}',
                        height: 150,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        movie.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
