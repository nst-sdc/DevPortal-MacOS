import AppKit
import WebKit

class LaunchScreenViewController: NSViewController {
    
    private let logoImageView: NSImageView = {
        let imageView = NSImageView()
        imageView.imageScaling = .scaleProportionallyUpOrDown
        if let image = NSImage(systemSymbolName: "bitcoinsign.circle.fill", accessibilityDescription: nil) {
            imageView.image = image
        }
        return imageView
    }()
    
    private let titleLabel: NSTextField = {
        let label = NSTextField(labelWithString: "DevClub")
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.alignment = .center
        label.alphaValue = 0
        return label
    }()
    
    override func loadView() {
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        animateLaunchScreen()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func animateLaunchScreen() {
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 1.0
            logoImageView.animator().frame = logoImageView.frame
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            NSAnimationContext.runAnimationGroup({ context in
                context.duration = 0.8
                self.titleLabel.animator().alphaValue = 1
            }) {
                self.navigateToMainScreen()
            }
        }
    }
    
    private func navigateToMainScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let mainVC = MainViewController()
            self.presentAsModalWindow(mainVC)
        }
    }
}
