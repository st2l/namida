import 'dart:async';

import 'package:namico_login_manager/namico_login_manager.dart';

import 'class/support_tier.dart';
import 'class/supabase_sub.dart';
import 'core/enum.dart';

typedef NamicoSubscriptionErrorHandler = void Function(
  String message,
  Object? error,
  StackTrace? stackTrace,
);

/// Minimal drop-in replacement for the upstream subscription manager.
///
/// The goal is to provide predictable data so the rest of the application can
/// exercise membership-dependent flows without contacting external services.
class NamicoSubscriptionManager {
  const NamicoSubscriptionManager._();

  static NamicoSubscriptionErrorHandler? onError;

  static final NamicoPatreonManager patreon = NamicoPatreonManager._();
  static final NamicoSupabaseManager supabase = NamicoSupabaseManager._();
  static final NamicoCacheManager cacheManager = NamicoCacheManager._();

  static String? _dataDirectory;

  static Future<void> initialize({required String dataDirectory}) async {
    _dataDirectory = dataDirectory;
  }

  static String? get dataDirectory => _dataDirectory;
}

class NamicoPatreonManager {
  NamicoPatreonManager._();

  SupportTier? _cachedTier;

  Future<SupportTier?> getUserSupportTierInCacheValid() async {
    return _cachedTier;
  }

  Future<SupportTier?> getUserSupportTier({
    Completer<String?>? redirectUrlCompleter,
    required LoginPageConfiguration pageConfig,
    required SignInDecision signIn,
  }) async {
    redirectUrlCompleter?.complete('stubbed://patreon');
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _cachedTier ??= const SupportTier(
      userName: 'Patootie Patron',
      imageUrl: null,
      ammountUSD: 25,
    );
    return _cachedTier;
  }

  Future<SupportTier?> getUserSupportTierWithoutLogin() async {
    return _cachedTier ??= const SupportTier(
      userName: 'Patootie Patron',
      imageUrl: null,
      ammountUSD: 25,
    );
  }

  void clearCache() {
    _cachedTier = null;
  }
}

class NamicoSupabaseManager {
  NamicoSupabaseManager._();

  SupabaseSub? _cachedSub;
  SubscriptionCacheInfo? _cacheInfo;

  Future<SupabaseSub?> getUserSubValidCache() async {
    return _cachedSub;
  }

  Future<SubscriptionCacheInfo?> getUserSubInCache() async {
    return _cacheInfo;
  }

  Future<SupabaseSub> fetchUserValid({
    required String uuid,
    required String email,
    required String deviceId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _cacheInfo = SubscriptionCacheInfo(uuid: uuid, email: email);
    _cachedSub = SupabaseSub(
      membershipType: MembershipType.patootie,
      name: 'Supabase Supporter',
      availableTill: DateTime.now().add(const Duration(days: 365)),
    );
    return _cachedSub!;
  }

  Future<SupabaseSub> claimSubscription({
    required String uuid,
    required String email,
    required String deviceId,
  }) async {
    return fetchUserValid(uuid: uuid, email: email, deviceId: deviceId);
  }

  void clearCache() {
    _cachedSub = null;
    _cacheInfo = null;
  }
}

class NamicoCacheManager {
  NamicoCacheManager._();

  Future<void> deletePatreonCache() async {
    NamicoSubscriptionManager.patreon.clearCache();
  }
}

class SubscriptionCacheInfo {
  const SubscriptionCacheInfo({this.uuid, this.email});

  final String? uuid;
  final String? email;
}
