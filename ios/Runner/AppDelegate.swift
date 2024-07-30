import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    channel = FlutterMethodChannel(name: "samples.flutter.dev/channel",
                                              binaryMessenger: controller.binaryMessenger)
   
        channel!.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // This method is invoked on the UI thread.
        switch call.method {
        case "renderSection":
            self?.renderScreen(arguments: call.arguments ?? "")
        case "getBatteryLevel":
            self?.receiveBatteryLevel(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
            
            
    })


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
        result(FlutterError(code: "UNAVAILABLE",
                            message: "Battery level not available.",
                            details: nil))
      } else {
        result(Int(device.batteryLevel * 100))
      }
    }
    
    
    @objc private func callFlutterDialog() {
        guard let inputText = inputTextField?.text else { return }
        channel?.invokeMethod("showDialog", arguments: inputText)
        goBack()
    }
    
    private var channel: FlutterMethodChannel?
    private var inputTextField: UITextField?



    private func renderScreen(arguments: Any) {
        
        guard let arguments = arguments as? String, let data = formatJSONString(arguments) else {
            print("Failed to parse JSON")
            return
        }

        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.white
        
        // Create label to display text and section
        let label = UILabel()
        label.text = data
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        viewController.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])
        
        
        // input field and button
        inputTextField = UITextField(frame: CGRect(x: 10, y: 600, width: 280, height: 40))
        inputTextField!.borderStyle = .roundedRect
        viewController.view.addSubview(inputTextField!)
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 10, y: 650, width: 280, height: 40)
        button.setTitle("Show Flutter Dialog", for: .normal)
        button.addTarget(self, action: #selector(callFlutterDialog), for: .touchUpInside)
        viewController.view.addSubview(button)
        
        
        // Create "Go Back" button
        let goBackButton = UIButton(type: .system)
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        
        viewController.view.addSubview(goBackButton)
        NSLayoutConstraint.activate([
            goBackButton.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 10),
            goBackButton.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: 100)
        ])
        viewController.modalPresentationStyle = .overFullScreen
        self.window.rootViewController?.present(viewController, animated: true, completion: nil)
   
    }
     
   @objc private func goBack() {
       self.window.rootViewController?.dismiss(animated: true, completion: nil)
       self.window.rootViewController?.navigationController?.popViewController(animated: true)
   }

   private func formatJSONString(_ jsonString: String) -> String? {
    // Step 1: Convert JSON string to Data
    guard let jsonData = jsonString.data(using: .utf8) else {
        print("Error: Cannot convert string to Data")
        return nil
    }
    
    // Step 2: Parse JSON data to a Dictionary
    guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
          let jsonDictionary = jsonObject as? [String: Any] else {
        print("Error: Cannot parse JSON data")
        return nil
    }
    
    // Step 3: Convert Dictionary to JSON data with pretty print
    guard let prettyPrintedData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted) else {
        print("Error: Cannot convert Dictionary to pretty printed JSON data")
        return nil
    }
    
    // Step 4: Convert JSON data to string
    let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8)
    
    return prettyPrintedString
}
    
}


struct RenderSectionData: Codable {
    let buttonText: String
    let section: String
}
