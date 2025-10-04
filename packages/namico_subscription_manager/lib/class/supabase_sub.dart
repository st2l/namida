import '../core/enum.dart';

/// Minimal representation of a Supabase-backed membership subscription.
class SupabaseSub {
  const SupabaseSub({
    required this.membershipType,
    this.name,
    this.availableTill,
  });

  final MembershipType membershipType;
  final String? name;
  final DateTime? availableTill;

  MembershipType toMembershipType() => membershipType;
}
