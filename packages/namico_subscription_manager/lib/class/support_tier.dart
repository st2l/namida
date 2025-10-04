import '../core/enum.dart';

/// Light-weight stand in for the real Patreon tier metadata.
class SupportTier {
  const SupportTier({
    this.userName,
    this.imageUrl,
    this.ammountUSD,
  });

  final String? userName;
  final String? imageUrl;
  final double? ammountUSD;

  /// Convert the amount the user pledges into an application tier.
  MembershipType toMembershipType() {
    final amount = ammountUSD ?? 0;
    if (amount >= 50) return MembershipType.owner;
    if (amount >= 20) return MembershipType.patootie;
    if (amount >= 10) return MembershipType.pookie;
    if (amount >= 1) return MembershipType.cutie;
    if (amount == 0) return MembershipType.none;
    return MembershipType.unknown;
  }
}
