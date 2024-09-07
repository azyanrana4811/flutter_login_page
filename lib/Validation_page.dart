// // import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Future<void> loginWithFacebook() async {
//   final LoginResult result = await FacebookAuth.instance.login(
//     permissions: ['email', 'public_profile'],
//   );

//   if (result.status == LoginStatus.success) {
//     final AccessToken accessToken = result.accessToken!;
//     final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
//     await FirebaseAuth.instance.signInWithCredential(credential);
//   } else {
//     print('Facebook login failed: ${result.message}');
//   }
// }


// Future<UserCredential?> signInWithGoogle() async {
//   try {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//     if (googleUser == null) {
//       // The user canceled the sign-in
//       return null;
//     }

//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;

//     final OAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   } catch (e) {
//     print('Error during Google sign-in: $e');
//     return null;
//   }
// }

// Future<UserCredential?> signInWithApple() async {
//   try {
//     final appleCredential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//     );

//     final OAuthCredential oauthCredential =
//         OAuthProvider("apple.com").credential(
//       idToken: appleCredential.identityToken,
//       accessToken: appleCredential.authorizationCode,
//     );

//     return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
//   } catch (e) {
//     print('Error during Apple sign-in: $e');
//     return null;
//   }
// }
