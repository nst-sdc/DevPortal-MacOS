import AppKit
import WebKit

class MainViewController: NSViewController {
    
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    private let customNavBar: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        return view
    }()
    
    private let segmentedControl: NSSegmentedControl = {
        let control = NSSegmentedControl(labels: ["Home", "About", "Services", "Contact"], trackingMode: .selectOne, target: nil, action: nil)
        control.selectedSegment = 0
        return control
    }()
    
    private let stackView: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.spacing = 0
        return stack
    }()
    
    private let buttons: [(title: String, selector: Selector)] = [
        ("Home", #selector(homePressed)),
        ("Dev Coins", #selector(devCoinsPressed)),
        ("Members", #selector(membersPressed)),
        ("Leaderboard", #selector(leaderboardPressed))
    ]
    
    private let authStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    override func loadView() {
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebsite(for: "Home")
        
        // Add action for segmented control
        segmentedControl.target = self
        segmentedControl.action = #selector(segmentChanged)
    }
    
    private func setupUI() {
        view.wantsLayer = true
        
        // Setup WebView
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup Navigation Bar
        view.addSubview(customNavBar)
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup Segmented Control
        customNavBar.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup Stack Views
        customNavBar.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add navigation buttons
        buttons.forEach { buttonInfo in
            let button = NSButton(title: buttonInfo.title, target: self, action: buttonInfo.selector)
            button.bezelStyle = .rounded
            stackView.addArrangedSubview(button)
        }
        
        // Setup Auth Buttons
        let signInButton = NSButton(title: "Sign In", target: self, action: #selector(signInPressed))
        signInButton.bezelStyle = .rounded
        
        let signUpButton = NSButton(title: "Sign Up", target: self, action: #selector(signUpPressed))
        signUpButton.bezelStyle = .rounded
        
        authStack.addArrangedSubview(signInButton)
        authStack.addArrangedSubview(signUpButton)
        stackView.addArrangedSubview(authStack)
        
        // Setup Constraints
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 100),
            
            segmentedControl.leadingAnchor.constraint(equalTo: customNavBar.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: customNavBar.trailingAnchor, constant: -20),
            segmentedControl.topAnchor.constraint(equalTo: customNavBar.topAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: customNavBar.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: customNavBar.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            webView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadWebsite(for section: String) {
        let urlString: String
        switch section {
        case "Home":
            urlString = "https://www.nstsdc.org/"
        case "About":
            urlString = "https://www.nstsdc.org/about"
        case "Services":
            urlString = "https://www.nstsdc.org/services"
        case "Contact":
            urlString = "https://www.nstsdc.org/contact"
        default:
            urlString = "https://www.nstsdc.org/"
        }
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc private func segmentChanged() {
        let selectedSegment = segmentedControl.selectedSegment
        let section = segmentedControl.label(forSegment: selectedSegment) ?? "Home"
        loadWebsite(for: section)
    }
    
    // MARK: - Button Actions
    
    @objc private func homePressed() {
        loadWebsite(for: "Home")
    }
    
    @objc private func devCoinsPressed() {
        // Implement dev coins navigation
    }
    
    @objc private func membersPressed() {
        // Implement members navigation
    }
    
    @objc private func leaderboardPressed() {
        // Implement leaderboard navigation
    }
    
    @objc private func signInPressed() {
        // Implement sign in
    }
    
    @objc private func signUpPressed() {
        // Implement sign up
    }
}
