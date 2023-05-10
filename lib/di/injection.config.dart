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
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../repository/history_repository.dart' as _i8;
import '../repository/picture_repository.dart' as _i10;
import '../repository/suggestion_repository.dart' as _i9;
import '../service/google_suggestion_service.dart' as _i6;
import '../service/pixabay_service.dart' as _i7;
import 'di_module.dart' as _i11;
import 'service/google_service_module.dart' as _i13;
import 'service/pixabay_service_module.dart' as _i14;
import 'service/service_base_module.dart' as _i12;

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
    final serviceBaseModule = _$ServiceBaseModule();
    final googleServiceModule = _$GoogleServiceModule();
    final pixabatServiceModule = _$PixabatServiceModule();
    gh.singleton<_i3.Alice>(
      registerModule.getAlice(),
      registerFor: {_dev},
    );
    gh.factory<Iterable<_i4.Interceptor>>(
      () => serviceBaseModule.getDevInterceptors(gh<_i3.Alice>()),
      registerFor: {_dev},
    );
    gh.factory<Iterable<_i4.Interceptor>>(
      () => serviceBaseModule.getProdInterceptors(),
      registerFor: {_prod},
    );
    await gh.factoryAsync<_i5.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i4.Dio>(
      () => googleServiceModule
          .getGoogleServiceDio(gh<Iterable<_i4.Interceptor>>()),
      instanceName: 'google',
    );
    gh.singleton<_i4.Dio>(
      pixabatServiceModule.getPixabayDio(gh<Iterable<_i4.Interceptor>>()),
      instanceName: 'pixabay',
    );
    gh.factory<_i6.GoogleSuggestionService>(() => googleServiceModule
        .getGoogleSuggestionService(gh<_i4.Dio>(instanceName: 'google')));
    gh.factory<_i7.PixabayService>(() =>
        pixabatServiceModule.getService(gh<_i4.Dio>(instanceName: 'pixabay')));
    gh.factory<_i8.QueryHistoryRepository>(
        () => _i8.QueryHistoryRepository.from(gh<_i5.SharedPreferences>()));
    gh.factory<_i9.SuggestionRepository>(
        () => _i9.SuggestionRepository(gh<_i6.GoogleSuggestionService>()));
    gh.factory<_i10.PictureRepository>(
        () => _i10.PictureRepository(gh<_i7.PixabayService>()));
    return this;
  }
}

class _$RegisterModule extends _i11.RegisterModule {}

class _$ServiceBaseModule extends _i12.ServiceBaseModule {}

class _$GoogleServiceModule extends _i13.GoogleServiceModule {}

class _$PixabatServiceModule extends _i14.PixabatServiceModule {}
