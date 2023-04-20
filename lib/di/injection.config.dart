// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../repository/history_repository.dart' as _i7;
import '../repository/picture_repository.dart' as _i6;
import '../service/pixabay_service.dart' as _i4;
import 'di_module.dart' as _i8;
import 'service_module.dart' as _i9;

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
    final serviceModule = _$ServiceModule();
    final registerModule = _$RegisterModule();
    gh.factory<_i3.Dio>(() => serviceModule.getDio());
    gh.factory<_i4.PixabayService>(
        () => serviceModule.getService(gh<_i3.Dio>()));
    await gh.factoryAsync<_i5.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i6.PictureRepository>(
        () => _i6.PictureRepository(gh<_i4.PixabayService>()));
    gh.factory<_i7.QueryHistoryRepository>(
        () => _i7.QueryHistoryRepository.from(gh<_i5.SharedPreferences>()));
    return this;
  }
}

class _$RegisterModule extends _i8.RegisterModule {}

class _$ServiceModule extends _i9.ServiceModule {}
