

class News {
  String? id;
  String? title;
  String? content_text;
  String? image;
  String? date_published;
 // String? authors;



  News({
    this.id,
    required this.title,
    required this.content_text,
    required this.image,
   this.date_published,
 //   this.authors

  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        id: json['_id'],
        title: json['title'],
        content_text: json['content_text'],
        image: json['image'],
       date_published: json['date_published'],
      //  authors: json['authors']
    );
  }


}
