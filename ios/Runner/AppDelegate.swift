import Flutter
import UIKit
import GoogleMaps // ← أضف هذه السطر

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // ← أضف هذا السطر قبل التسجيل
    GMSServices.provideAPIKey("AIzaSyCTh2cSDnCmblafoa1Kz6DyjMOpFzAqMp0") // استبدل المفتاح بمفتاحك الفعلي من Google Cloud Console
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
