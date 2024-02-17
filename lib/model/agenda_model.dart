// ignore_for_file: unnecessary_null_comparison

class AgendaModel {
  List<ContatoModel> results = [];

  AgendaModel(this.results);

  AgendaModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ContatoModel>[];
      json['results'].forEach((v) {
        results.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContatoModel {
  String? objectId;
  String? nome;
  String? phone;
  String? thumbPath;
  String? createdAt;
  String? updatedAt;

  ContatoModel(
      {this.objectId,
      this.nome,
      this.phone,
      this.thumbPath,
      this.createdAt,
      this.updatedAt});

  ContatoModel.criar(this.nome, this.phone, this.thumbPath);

  ContatoModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    nome = json['nome'];
    phone = json['phone'];
    thumbPath = json['thumb_path'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['nome'] = nome;
    data['phone'] = phone;
    data['thumb_path'] = thumbPath;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
