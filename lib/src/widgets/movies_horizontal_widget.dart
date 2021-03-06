import 'package:flutter/material.dart';
import 'package:sarin/src/models/movie_models.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) =>
            _card(context, movies[index]),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-poster';
    final returnResult = Container(
      margin: EdgeInsets.only(right: 5.0),
      child: Column(
        children: <Widget>[
          Hero(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.16,
              ),
            ),
            tag: movie.uniqueId,
          ),
          SizedBox(height: 5.0),
          Text(movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption)
        ],
      ),
    );
    return GestureDetector(
      child: returnResult,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }

  List<Widget> _cardsMovies(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 5.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(movie.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption)
          ],
        ),
      );
    }).toList();
  }
}
