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
            self?.renderScreen(arguments: call.arguments)
        default:
            result(FlutterMethodNotImplemented)
        }
            
            
    })


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    @objc private func callFlutterDialog() {
        guard let inputText = inputTextField?.text else { return }
        channel?.invokeMethod("showDialog", arguments: inputText)
    }
    
    private var channel: FlutterMethodChannel?
    private var inputTextField: UITextField?



    private func renderScreen(arguments: Any) {
        
        guard let arguments = arguments as? String, let data = parseJSON(arguments) else {
            print("Failed to parse JSON")
            return
        }

        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.white
        
        // Create label to display text and section
        let label = UILabel()
        label.text = "Text: \(data.buttonText)\nSection: \(data.section)"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        viewController.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])
        
        
        // input field and button
        inputTextField = UITextField(frame: CGRect(x: 10, y: 200, width: 280, height: 40))
        inputTextField!.borderStyle = .roundedRect
        viewController.view.addSubview(inputTextField!)
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 10, y: 250, width: 280, height: 40)
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
    
    private func parseJSON(_ jsonString: String) -> RenderSectionData? {
           let data = jsonString.data(using: .utf8)!
           return try? JSONDecoder().decode(RenderSectionData.self, from: data)
       }
       
   @objc private func goBack() {
       self.window.rootViewController?.dismiss(animated: true, completion: nil)
       self.window.rootViewController?.navigationController?.popViewController(animated: true)
   }
    
}


struct RenderSectionData: Codable {
    let buttonText: String
    let section: String
}
