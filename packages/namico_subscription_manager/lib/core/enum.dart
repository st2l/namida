/// Mirror of the membership levels used inside the app.
///
/// The exact order matters because the application compares the [index]
/// to decide which tier unlocks a feature. Keep the list aligned with the
/// original package so existing comparisons remain valid.
enum MembershipType {
  unknown,
  none,
  cutie,
  pookie,
  patootie,
  owner,
}
