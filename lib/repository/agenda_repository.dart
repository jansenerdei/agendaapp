import 'package:agendaapp/model/agenda_model.dart';
import 'package:agendaapp/repository/agenda_custom_dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AgendaRepository {
  final _customDio = AgendaCustomDio();
  var url = dotenv.get("AGENDA_BASEURL");

  AgendaRepository();

  Future<AgendaModel> obterAgenda() async {
    var result = await _customDio.dio.get(url);
    return AgendaModel.fromJson(result.data);
  }

  Future<void> criarContato(ContatoModel contato) async {
    try {
      await _customDio.dio.post(url, data: contato.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizarContato(ContatoModel contato) async {
    try {
      var response = await _customDio.dio
          .put("$url/${contato.nome}", data: contato.toJson());
    } catch (e) {
      rethrow;
    }

    Future<void> removerCadastro(String objectId) async {
      try {
        var response = await _customDio.dio.delete("$url/$objectId");
      } catch (e) {
        rethrow;
      }
    }
  }
}
