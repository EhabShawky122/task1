class Movies{
  late String title,overview,poster_path,photo,release_date;
  late double vote_average,vote_count;
  Movies();
  Movies.name(Map<String,dynamic> map){
    this.title=map['title'];
    this.overview=map['overview'];
    this.poster_path=map['poster_path'];
    this.photo='https://image.tmdb.org/t/p/original/$poster_path';
    this.vote_average=map['vote_average']/2;
    this.vote_count=map['vote_count'];
    this.release_date=map['release_date'];

  }
}