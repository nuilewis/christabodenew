// Mocks generated by Mockito 5.4.4 from annotations
// in christabodenew/test/providers/prayer_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:christabodenew/core/errors/failure.dart' as _i7;
import 'package:christabodenew/models/prayer_model.dart' as _i8;
import 'package:christabodenew/repositories/prayer_repository.dart' as _i5;
import 'package:christabodenew/services/prayer/prayer_firestore_service.dart'
    as _i2;
import 'package:christabodenew/services/prayer/prayer_hive_service.dart' as _i3;
import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePrayerFireStoreService_0 extends _i1.SmartFake
    implements _i2.PrayerFireStoreService {
  _FakePrayerFireStoreService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePrayerHiveService_1 extends _i1.SmartFake
    implements _i3.PrayerHiveService {
  _FakePrayerHiveService_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PrayerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPrayerRepository extends _i1.Mock implements _i5.PrayerRepository {
  @override
  _i2.PrayerFireStoreService get prayerFirestoreService => (super.noSuchMethod(
        Invocation.getter(#prayerFirestoreService),
        returnValue: _FakePrayerFireStoreService_0(
          this,
          Invocation.getter(#prayerFirestoreService),
        ),
        returnValueForMissingStub: _FakePrayerFireStoreService_0(
          this,
          Invocation.getter(#prayerFirestoreService),
        ),
      ) as _i2.PrayerFireStoreService);

  @override
  _i3.PrayerHiveService get prayerHiveService => (super.noSuchMethod(
        Invocation.getter(#prayerHiveService),
        returnValue: _FakePrayerHiveService_1(
          this,
          Invocation.getter(#prayerHiveService),
        ),
        returnValueForMissingStub: _FakePrayerHiveService_1(
          this,
          Invocation.getter(#prayerHiveService),
        ),
      ) as _i3.PrayerHiveService);

  @override
  _i6.Future<_i4.Either<_i7.Failure, List<_i8.Prayer>>> getPrayers() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPrayers,
          [],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i7.Failure, List<_i8.Prayer>>>.value(
                _FakeEither_2<_i7.Failure, List<_i8.Prayer>>(
          this,
          Invocation.method(
            #getPrayers,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.Failure, List<_i8.Prayer>>>.value(
                _FakeEither_2<_i7.Failure, List<_i8.Prayer>>(
          this,
          Invocation.method(
            #getPrayers,
            [],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, List<_i8.Prayer>>>);

  @override
  _i6.Future<_i4.Either<_i7.Failure, _i8.Prayer>> getCurrentPrayer() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentPrayer,
          [],
        ),
        returnValue: _i6.Future<_i4.Either<_i7.Failure, _i8.Prayer>>.value(
            _FakeEither_2<_i7.Failure, _i8.Prayer>(
          this,
          Invocation.method(
            #getCurrentPrayer,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.Failure, _i8.Prayer>>.value(
                _FakeEither_2<_i7.Failure, _i8.Prayer>(
          this,
          Invocation.method(
            #getCurrentPrayer,
            [],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, _i8.Prayer>>);

  @override
  _i6.Future<_i4.Either<_i7.Failure, int>> getCurrentPrayerIndex() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentPrayerIndex,
          [],
        ),
        returnValue: _i6.Future<_i4.Either<_i7.Failure, int>>.value(
            _FakeEither_2<_i7.Failure, int>(
          this,
          Invocation.method(
            #getCurrentPrayerIndex,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.Failure, int>>.value(
                _FakeEither_2<_i7.Failure, int>(
          this,
          Invocation.method(
            #getCurrentPrayerIndex,
            [],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, int>>);

  @override
  _i6.Future<_i4.Either<_i7.Failure, List<_i8.Prayer>>> getLikedPrayers() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLikedPrayers,
          [],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i7.Failure, List<_i8.Prayer>>>.value(
                _FakeEither_2<_i7.Failure, List<_i8.Prayer>>(
          this,
          Invocation.method(
            #getLikedPrayers,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.Failure, List<_i8.Prayer>>>.value(
                _FakeEither_2<_i7.Failure, List<_i8.Prayer>>(
          this,
          Invocation.method(
            #getLikedPrayers,
            [],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, List<_i8.Prayer>>>);

  @override
  _i6.Future<_i4.Either<_i7.Failure, void>> updatePrayerSavedList(
          List<_i8.Prayer>? updatedList) =>
      (super.noSuchMethod(
        Invocation.method(
          #updatePrayerSavedList,
          [updatedList],
        ),
        returnValue: _i6.Future<_i4.Either<_i7.Failure, void>>.value(
            _FakeEither_2<_i7.Failure, void>(
          this,
          Invocation.method(
            #updatePrayerSavedList,
            [updatedList],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.Failure, void>>.value(
                _FakeEither_2<_i7.Failure, void>(
          this,
          Invocation.method(
            #updatePrayerSavedList,
            [updatedList],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, void>>);

  @override
  _i6.Future<_i4.Either<_i7.Failure, void>> clearPrayers() =>
      (super.noSuchMethod(
        Invocation.method(
          #clearPrayers,
          [],
        ),
        returnValue: _i6.Future<_i4.Either<_i7.Failure, void>>.value(
            _FakeEither_2<_i7.Failure, void>(
          this,
          Invocation.method(
            #clearPrayers,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.Either<_i7.Failure, void>>.value(
                _FakeEither_2<_i7.Failure, void>(
          this,
          Invocation.method(
            #clearPrayers,
            [],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, void>>);
}
