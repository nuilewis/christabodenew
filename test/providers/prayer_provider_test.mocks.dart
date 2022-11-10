// Mocks generated by Mockito 5.3.2 from annotations
// in christabodenew/test/providers/prayer_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:christabodenew/core/errors/failure.dart' as _i5;
import 'package:christabodenew/models/prayer_model.dart' as _i6;
import 'package:christabodenew/repositories/prayer_repository.dart' as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
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
class MockPrayerRepository extends _i1.Mock implements _i3.PrayerRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>> getCurrentPrayer() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentPrayer,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>.value(
            _FakeEither_0<_i5.Failure, _i6.Prayer>(
          this,
          Invocation.method(
            #getCurrentPrayer,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>.value(
                _FakeEither_0<_i5.Failure, _i6.Prayer>(
          this,
          Invocation.method(
            #getCurrentPrayer,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>> getNextPrayer() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNextPrayer,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>.value(
            _FakeEither_0<_i5.Failure, _i6.Prayer>(
          this,
          Invocation.method(
            #getNextPrayer,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>.value(
                _FakeEither_0<_i5.Failure, _i6.Prayer>(
          this,
          Invocation.method(
            #getNextPrayer,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>> getPreviousPrayer() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPreviousPrayer,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>.value(
            _FakeEither_0<_i5.Failure, _i6.Prayer>(
          this,
          Invocation.method(
            #getPreviousPrayer,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>.value(
                _FakeEither_0<_i5.Failure, _i6.Prayer>(
          this,
          Invocation.method(
            #getPreviousPrayer,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>> getPrayer() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPrayer,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>.value(
            _FakeEither_0<_i5.Failure, _i6.Prayer>(
          this,
          Invocation.method(
            #getPrayer,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>.value(
                _FakeEither_0<_i5.Failure, _i6.Prayer>(
          this,
          Invocation.method(
            #getPrayer,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Prayer>>);
}