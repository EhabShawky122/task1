import 'dart:io';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dio/dio.dart';
import 'movies.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Movie Hunt",
        theme: ThemeData(scaffoldBackgroundColor: Colors.blueGrey[900]),
        home: MyHomePage(
          title: 'Movie app',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movies> movies = [];
  List<Movies> movies1 = [];


  @override
  void initState() {
    getMovies();
    getMovies1();

    super.initState();
  }

  getMovies() async {
    var response = await Dio().get(
      "https://api.themoviedb.org/3/movie/popular",
      queryParameters: {
        "api_key": 'f55fbda0cb73b855629e676e54ab6d8e',
      },
    );
    for (int i = 0; i < (response.data['results'] as List).length; i++) {
      Movies movie = new Movies.name(response.data['results'][i]);
      movies.add(movie);
    }
    setState(() {});
  }

  getMovies1() async {
    var response = await Dio().get(
      "https://api.themoviedb.org/3/movie/now_playing",
      queryParameters: {
        "api_key": 'f55fbda0cb73b855629e676e54ab6d8e',
      },
    );
    for (int i = 0; i < (response.data['results'] as List).length; i++) {
      Movies movie1 = new Movies.name(response.data['results'][i]);
      movies1.add(movie1);
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MovieHunt',
          style: TextStyle(color: Colors.cyan),
        ),
        backgroundColor: Colors.black12,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(width: double.infinity,height: 10,color: Colors.black,)
              ,Row(
                children: [
                  Expanded(
                      child: Text(
                    'Now Playing',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  )),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondPage(title: 'movie app',)));
                      },
                      child: Text(
                        'view all',
                        style: TextStyle(
                            color: Colors.cyan,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      )),
                ],
              ),
              Container(
                width: double.infinity,
                height: 400,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: movies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Movies movie = movies[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ThirdPage(name: movie.title,photo: movie.photo,overview: movie.overview,rate: movie.vote_average,)));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 400,
                            padding: EdgeInsets.all(10),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                   Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 400,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(child: Image.network(movie.photo,fit: BoxFit.fill,)),
                                            Text(movie.title,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: RatingBar.builder(
                                                    itemSize: 7,
                                                    initialRating:
                                                        movie.vote_average,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.cyan,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  movie.vote_count.toString() +
                                                      'reviews',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.access_alarms),
                                                Text('2h,14m',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                ),
              )
              ,Container(
                width: double.infinity,height: 10,color: Colors.black,
              ),Row(
                children: [
                  Expanded(
                      child: Text(
                        'popular',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SecondPage(title: 'movie app',)));
                      },
                      child: Text(
                        'view all',
                        style: TextStyle(
                            color: Colors.cyan,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      )),
                ],
              ),
              Container(
                width: double.infinity,
                height: 180,
                padding: EdgeInsets.all(10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: movies.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                Movies movie1 = movies1[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ThirdPage(rate: movie1.vote_average,photo: movie1.photo,name: movie1.title,overview: movie1.overview,)));
                                  },child:Container(
                                  width: 80,
                                  height: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                          child: Image.network(movie1.photo,
                                            fit: BoxFit.fill,
                                          )),
                                      Text(movie1.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight
                                                .w700,
                                          )),
                                      Row(
                                        children: [
                                          Icon(Icons.add_reaction),
                                          Text('89.6%')
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              )],
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  SecondPage({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  SecondPageState createState() => SecondPageState();}
class SecondPageState extends State<SecondPage>{
  List<Movies> movies2 = [];

  @override
  void initState() {
    getMovies2();
    super.initState();
  }

  getMovies2() async {

    var response = await Dio().get(
      "http://api.themoviedb.org/3/movie/top_rated",
      queryParameters: {
        "api_key": 'f55fbda0cb73b855629e676e54ab6d8e',
      },
    );
    for (int i = 0; i < (response.data['results'] as List).length; i++) {
      Movies movie2 = new Movies.name(response.data['results'][i]);
      movies2.add(movie2);
    }
    setState(() {});
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
      title: Text(
      'Now playing',
      style: TextStyle(color: Colors.white),
  ),
  ),
  body:ListView(
    children: [
      Container(
        width: double.infinity,height: 10,color: Colors.black,
      ),Container(width:double.infinity ,height: 750,
        child: ListView.builder(shrinkWrap: true,itemCount:movies2.length,scrollDirection:Axis.vertical,itemBuilder: (context,index){
          Movies movie2= movies2[index];
          return GestureDetector(
              onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ThirdPage(rate: movie2.vote_average,photo: movie2.photo,name: movie2.title,overview: movie2.overview,)));
          },child:Container(margin: EdgeInsets.all(5),height: 200,width: double.infinity,
            child: Wrap(spacing: 10,runSpacing: 10,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(8),child: Image.network(movie2.photo,fit: BoxFit.fill,height: 200,width: 250,)),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movie2.title,
                              style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                          )),
                              Row(mainAxisSize: MainAxisSize.min,
                                children: [
                                RatingBar.builder(
                                  itemSize: 7,
                                  initialRating:
                                  movie2.vote_average,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                  EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) =>
                                      Icon(
                                        Icons.star,
                                        color: Colors.cyan,
                                      ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),SizedBox(width: 8,),
                                Text(
                                  movie2.vote_count.toString() +
                                      'reviews',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12),
                                )
                              ],

                              ),Row(
                                children: [
                                  Icon(Icons.access_alarms),
                                  Text('2h,14m',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ))
                                ],
                              ),Row(
                                children: [
                                  Icon(Icons.timer),
                                  Text(movie2.release_date,
                                      style: TextStyle(
                                        fontSize: 10,
                                      ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ));
        }
        ),
      )],
  )
  );
  }
}

class ThirdPage extends StatelessWidget{
  ThirdPage({Key? key,required this.photo,required this.name,required this.overview,required this.rate}):super(key:key);
 final String photo,name,overview;
 final double rate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(width:double.infinity ,height: 750,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Expanded(
          child: Image.network(photo,fit: BoxFit.fill,)),
        Text(
        name,
        style: TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
    ),
    Row(
    children: [
    RatingBar.builder(
    itemSize: 15,
    initialRating: rate,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => Icon(
    Icons.star,
    color: Colors.cyan,
    ),
    onRatingUpdate: (rating) {
    print(rating);
    },
    ),
    Text(
    '2.6k reviews',
    style: TextStyle(color: Colors.white, fontSize: 12),
    )
    ],
    ),
    Row(
    children: [
    Icon(Icons.access_alarms),
    Text('2h,14m',
    style: TextStyle(
    fontSize: 10,
    ))
    ],
    ),
    Row(
    children: [
    Icon(Icons.add_business_outlined),
    Text('2019/12/31',
    style: TextStyle(
    fontSize: 10,
    ))
    ],
    ),
    Text(
      overview,    style: TextStyle(color: Colors.white, fontSize: 16),
    )

      ]
    )
      )
    );
  }
}

