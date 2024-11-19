class storemepmodel {
  List<Stories>? stories;
  storemepmodel({this.stories});
  storemepmodel.fromJson(Map<String, dynamic> json) {
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add(new Stories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stories != null) {
      data['stories'] = this.stories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stories {
  int? id;
  String? text;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Stories({this.id, this.text, this.imageUrl, this.createdAt, this.updatedAt});

  Stories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}