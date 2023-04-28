// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:alice/alice.dart' as _i3;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../repository/history_repository.dart' as _i8;
import '../repository/picture_repository.dart' as _i7;
import '../service/pixabay_service.dart' as _i5;
import 'di_module.dart' as _i10;
import 'service_module.dart' as _i9;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    final serviceModule = _$ServiceModule();
    gh.singleton<_i3.Alice>(registerModule.getAlice());
    gh.factory<_i4.Dio>(
      () => serviceModule.getDevDio(gh<_i3.Alice>()),
      registerFor: {_dev},
    );
    gh.factory<_i4.Dio>(
      () => serviceModule.getProDio(),
      registerFor: {_prod},
    );
    gh.factory<_i5.PixabayService>(
        () => serviceModule.getService(gh<_i4.Dio>()));
    await gh.factoryAsync<_i6.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i7.PictureRepository>(
        () => _i7.PictureRepository(gh<_i5.PixabayService>()));
    gh.factory<_i8.QueryHistoryRepository>(
        () => _i8.QueryHistoryRepository.from(gh<_i6.SharedPreferences>()));
    return this;
  }
}

class _$ServiceModule extends _i9.ServiceModule {}

class _$RegisterModule extends _i10.RegisterModule {}
