import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
 static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  SharedPreferences? _prefs;

  Preferences._internal();

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  clearPreferences() async {
    await _prefs!.clear();
  }

/////////////////////////////////////////////////////////
  get locacionId {
    return _prefs!.getString('locacionId');
  }

  set locacionIds(String value) {
    _prefs!.setString('locacionId', value);
  }

/////////////////////////////////////////////////////////
  get token {
    return _prefs!.getString('token');
  }

  set tokens(String value) {
    _prefs!.setString('token', value);
  }

/////////////////////////////////////////////////////////
  get idUsuario {
    return _prefs!.getString('idUsuario');
  }

  set idUsuarios(String value) {
    _prefs!.setString('idUsuario', value);
  }

/////////////////////////////////////////////////////////
  get nombresCompletos {
    return _prefs!.getString('nombresCompletos');
  }

  set nombresCompletoss(String value) {
    _prefs!.setString('nombresCompletos', value);
  }

/////////////////////////////////////////////////////////
  get codigoUsuario {
    return _prefs!.getString('codigoUsuario');
  }

  set codigoUsuarioss(String value) {
    _prefs!.setString('codigoUsuario', value);
  }

/////////////////////////////////////////////////////////
  get nombres {
    return _prefs!.getString('nombres');
  }

  set nombress(String value) {
    _prefs!.setString('nombres', value);
  }

/////////////////////////////////////////////////////////
  get apellidoPaterno {
    return _prefs!.getString('apellidoPaterno');
  }

  set apellidoPaternos(String value) {
    _prefs!.setString('apellidoPaterno', value);
  }

/////////////////////////////////////////////////////////
  get apellidoMaterno {
    return _prefs!.getString('apellidoMaterno');
  }

  set apellidoMaternos(String value) {
    _prefs!.setString('apellidoMaterno', value);
  }

/////////////////////////////////////////////////////////
  get tiendaId {
    return _prefs!.getString('tiendaId');
  }

  set tiendaIds(String value) {
    _prefs!.setString('tiendaId', value);
  }

  get negocioImagen {
    return _prefs!.getString('negocioImagen');
  }

  set negocioImagens(String value) {
    _prefs!.setString('negocioImagen', value);
  }

  get negocioNombre {
    return _prefs!.getString('negocioNombre');
  }

  set negocioNombres(String value) {
    _prefs!.setString('negocioNombre', value);
  }

/////////////////////////////////////////////////////////
  get url {
    return _prefs!.getString('url');
  }

  set urls(String value) {
    _prefs!.setString('url', value);
  }

/////////////////////////////////////////////////////////
  get llamadaLocacion {
    return _prefs!.getString('llamadaLocacion');
  }

  set llamadaLocacions(String value) {
    _prefs!.setString('llamadaLocacion', value);
  }

  /////////////////////////////////////////////////////////
  get esComanda {
    return _prefs!.getBool('esComanda');
  }

  set esComandas(bool value) {
    _prefs!.setBool('esComanda', value);
  }

  get idEnviarEnComanda {
    return _prefs!.getString('idEnviarEnComanda');
  }

  set idEnviarEnComandas(String value) {
    _prefs!.setString('idEnviarEnComanda', value);
  }

  get idMesa {
    return _prefs!.getString('idMesa');
  }

  set idMesas(String value) {
    _prefs!.setString('idMesa', value);
  }

  get indexSelect {
    return _prefs!.getInt('indexSelect');
  }

  set indexSelects(int value) {
    _prefs!.setInt('indexSelect', value);
  }
}
