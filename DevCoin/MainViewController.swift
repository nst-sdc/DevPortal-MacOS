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
    
    private let stackView: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .centerY
        stack.spacing = 20
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
        loadWebsite()
        
        // Add animation to the navigation bar
        customNavBar.alphaValue = 0
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.8
            context.timingFunction = CAMediaTimingFunction(name: .easeIn)
            customNavBar.animator().alphaValue = 1
        })
    }
    
    private func setupUI() {
        view.wantsLayer = true
        
        // Setup WebView
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup Navigation Bar
        view.addSubview(customNavBar)
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        
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
            customNavBar.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.leadingAnchor.constraint(equalTo: customNavBar.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: customNavBar.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: customNavBar.centerYAnchor),
            
            webView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadWebsite() {
        guard let url = URL(string: "https://www.nstsdc.org/") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - Button Actions
    
    @objc private func homePressed() {
        loadWebsite()
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
