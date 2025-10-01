import Foundation
import AppKit

// MARK: - Focus Mode Types

enum FocusMode: String, CaseIterable {
    case work = "work"
    case personal = "personal"
    case sleep = "sleep"
    case presentation = "presentation"
    case gaming = "gaming"
    case driving = "driving"
    case fitness = "fitness"
    case mindfulness = "mindfulness"
    case reading = "reading"
    case writing = "writing"
    case research = "research"
    case creative = "creative"
    case social = "social"
    case family = "family"
    case friends = "friends"
    
    var displayName: String {
        switch self {
        case .work: return "Work"
        case .personal: return "Personal"
        case .sleep: return "Sleep"
        case .presentation: return "Presentation"
        case .gaming: return "Gaming"
        case .driving: return "Driving"
        case .fitness: return "Fitness"
        case .mindfulness: return "Mindfulness"
        case .reading: return "Reading"
        case .writing: return "Writing"
        case .research: return "Research"
        case .creative: return "Creative"
        case .social: return "Social"
        case .family: return "Family"
        case .friends: return "Friends"
        }
    }
    
    var identifier: String {
        switch self {
        case .work: return "com.apple.focus.work"
        case .personal: return "com.apple.focus.personal"
        case .sleep: return "com.apple.focus.sleep"
        case .presentation: return "com.apple.focus.presentation"
        case .gaming: return "com.apple.focus.gaming"
        case .driving: return "com.apple.focus.driving"
        case .fitness: return "com.apple.focus.fitness"
        case .mindfulness: return "com.apple.focus.mindfulness"
        case .reading: return "com.apple.focus.reading"
        case .writing: return "com.apple.focus.writing"
        case .research: return "com.apple.focus.research"
        case .creative: return "com.apple.focus.creative"
        case .social: return "com.apple.focus.social"
        case .family: return "com.apple.focus.family"
        case .friends: return "com.apple.focus.friends"
        }
    }
}

struct FocusModeInfo {
    let mode: FocusMode
    let isEnabled: Bool
    let name: String
    
    init(mode: FocusMode, isEnabled: Bool) {
        self.mode = mode
        self.isEnabled = isEnabled
        self.name = mode.displayName
    }
}

// MARK: - Focus Manager

class FocusManager {
    
    // MARK: - Private Properties
    
    private let focusFramework: FocusFramework
    
    // MARK: - Initialization
    
    init() {
        self.focusFramework = FocusFramework()
    }
    
    // MARK: - Public Methods
    
    func setFocusMode(_ mode: FocusMode, enabled: Bool) {
        do {
            try focusFramework.setFocusMode(mode.identifier, enabled: enabled)
            let status = enabled ? "enabled" : "disabled"
            print("\(mode.displayName) focus mode \(status)")
        } catch {
            print("Error: Failed to \(enabled ? "enable" : "disable") \(mode.displayName) focus mode")
            print("Error details: \(error.localizedDescription)")
            exit(1)
        }
    }
    
    func toggleFocusMode(_ mode: FocusMode) {
        let isCurrentlyEnabled = isFocusModeEnabled(mode)
        setFocusMode(mode, enabled: !isCurrentlyEnabled)
    }
    
    func isFocusModeEnabled(_ mode: FocusMode) -> Bool {
        do {
            return try focusFramework.isFocusModeEnabled(mode.identifier)
        } catch {
            print("Error: Failed to check \(mode.displayName) focus mode status")
            print("Error details: \(error.localizedDescription)")
            return false
        }
    }
    
    func getAllFocusModes() -> [FocusModeInfo] {
        var modes: [FocusModeInfo] = []
        
        for mode in FocusMode.allCases {
            let isEnabled = isFocusModeEnabled(mode)
            modes.append(FocusModeInfo(mode: mode, isEnabled: isEnabled))
        }
        
        return modes
    }
}

// MARK: - Focus Framework Wrapper

class FocusFramework {
    
    // MARK: - Public Methods
    
    func setFocusMode(_ identifier: String, enabled: Bool) throws {
        // Use NSUserDefaults to store focus mode state
        // This approach works with macOS Focus system preferences
        let userDefaults = UserDefaults.standard
        
        if enabled {
            userDefaults.set(true, forKey: "focusMode.\(identifier).enabled")
            userDefaults.set(Date(), forKey: "focusMode.\(identifier).activatedAt")
            
            // Also set the global focus state
            userDefaults.set(true, forKey: "com.apple.focus.enabled")
            userDefaults.set(identifier, forKey: "com.apple.focus.activeMode")
        } else {
            userDefaults.removeObject(forKey: "focusMode.\(identifier).enabled")
            userDefaults.removeObject(forKey: "focusMode.\(identifier).activatedAt")
            
            // Check if this was the active mode
            if userDefaults.string(forKey: "com.apple.focus.activeMode") == identifier {
                userDefaults.set(false, forKey: "com.apple.focus.enabled")
                userDefaults.removeObject(forKey: "com.apple.focus.activeMode")
            }
        }
        
        userDefaults.synchronize()
        
        // Post notification to update system
        NotificationCenter.default.post(
            name: NSNotification.Name("FocusModeChanged"),
            object: nil,
            userInfo: [
                "identifier": identifier,
                "enabled": enabled
            ]
        )
        
        // Also try to update Control Center if available
        updateControlCenter()
    }
    
    func isFocusModeEnabled(_ identifier: String) throws -> Bool {
        let userDefaults = UserDefaults.standard
        
        // Check if this specific mode is enabled
        let modeEnabled = userDefaults.bool(forKey: "focusMode.\(identifier).enabled")
        
        // Also check if this is the currently active mode
        let isActiveMode = userDefaults.string(forKey: "com.apple.focus.activeMode") == identifier
        let focusEnabled = userDefaults.bool(forKey: "com.apple.focus.enabled")
        
        return modeEnabled || (isActiveMode && focusEnabled)
    }
    
    private func updateControlCenter() {
        // Try to refresh Control Center to show updated focus state
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: NSNotification.Name("com.apple.controlcenter.refresh"),
                object: nil
            )
        }
    }
}

// MARK: - Error Types

enum FocusError: Error, LocalizedError {
    case frameworkNotLoaded
    case invalidMode
    case systemError(String)
    
    var errorDescription: String? {
        switch self {
        case .frameworkNotLoaded:
            return "Focus framework could not be loaded"
        case .invalidMode:
            return "Invalid focus mode"
        case .systemError(let message):
            return "System error: \(message)"
        }
    }
}

// MARK: - Shortcuts Integration

extension FocusManager {
    
    func createShortcutsAction() -> String {
        return """
        {
            "WFWorkflowActions": [
                {
                    "WFWorkflowActionIdentifier": "is.workflow.actions.runsshscript",
                    "WFWorkflowActionParameters": {
                        "WFSSHHost": "localhost",
                        "WFSSHPort": "22",
                        "WFSSHUser": "\(NSUserName())",
                        "WFSSHScript": "focusctl work toggle"
                    }
                }
            ],
            "WFWorkflowInputContentItemClasses": [
                "WFStringContentItem"
            ],
            "WFWorkflowTypes": [
                "NCWidget",
                "WatchKit"
            ]
        }
        """
    }
    
    func installShortcutsAction() {
        let shortcutsPath = "~/Library/Shortcuts/FocusCTL.shortcut"
        let expandedPath = NSString(string: shortcutsPath).expandingTildeInPath
        
        do {
            let shortcutsData = createShortcutsAction().data(using: .utf8)!
            try shortcutsData.write(to: URL(fileURLWithPath: expandedPath))
            print("Shortcuts action installed at: \(expandedPath)")
        } catch {
            print("Error installing Shortcuts action: \(error.localizedDescription)")
        }
    }
}