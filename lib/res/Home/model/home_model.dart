class HomeResultModel {
  List<Results>? results;

  HomeResultModel({
    this.results,
  });

  HomeResultModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Results {
  String? imageUrl;
  String? title;
  String? body;

  Results({
    this.imageUrl,
    this.title,
    this.body,
  });

  Results.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    title = json['title'];

    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;

    data['body'] = this.body;

    return data;
  }
}
