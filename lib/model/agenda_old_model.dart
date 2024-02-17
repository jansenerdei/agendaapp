class AgendaModel {
  List<ContatoModel> agenda = [];

  AgendaModel(this.agenda);

  AgendaModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      agenda = <ContatoModel>[];
      json['results'].forEach((v) {
        agenda.add(ContatoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = agenda.map((e) => e.toJson()).toList();
    return data;
  }
}

class ContatoModel {
  String? nome;
  String? phone;
  String? thumbPath;

  ContatoModel({this.nome, this.phone, this.thumbPath});

  ContatoModel.criar(this.nome, this.phone, this.thumbPath);

  ContatoModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    phone = json['phone'];
    thumbPath = json['thumb_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['phone'] = phone;
    data['thumb_path'] = thumbPath;
    return data;
  }
}
