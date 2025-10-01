import Foundation
import AppKit

// MARK: - Shortcuts Action Manager

class ShortcutsActionManager {
    
    // MARK: - Private Properties
    
    private let shortcutsDirectory: URL
    private let actionName = "FocusCTL"
    
    // MARK: - Initialization
    
    init() {
        let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
        self.shortcutsDirectory = homeDirectory.appendingPathComponent("Library/Shortcuts")
        
        // Create shortcuts directory if it doesn't exist
        createShortcutsDirectoryIfNeeded()
    }
    
    // MARK: - Private Methods
    
    private func createShortcutsDirectoryIfNeeded() {
        if !FileManager.default.fileExists(atPath: shortcutsDirectory.path) {
            do {
                try FileManager.default.createDirectory(
                    at: shortcutsDirectory,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            } catch {
                print("Warning: Could not create Shortcuts directory: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Public Methods
    
    func createFocusModeAction(for mode: FocusMode) -> ShortcutsAction {
        return ShortcutsAction(
            identifier: "\(actionName).\(mode.rawValue)",
            name: "Toggle \(mode.displayName) Focus",
            description: "Toggle \(mode.displayName) focus mode on/off",
            script: "focusctl \(mode.rawValue) toggle",
            icon: getIconForMode(mode)
        )
    }
    
    func createWorkAction() -> ShortcutsAction {
        return createFocusModeAction(for: .work)
    }
    
    func createPersonalAction() -> ShortcutsAction {
        return createFocusModeAction(for: .personal)
    }
    
    func createSleepAction() -> ShortcutsAction {
        return createFocusModeAction(for: .sleep)
    }
    
    func createPresentationAction() -> ShortcutsAction {
        return createFocusModeAction(for: .presentation)
    }
    
    func installAction(_ action: ShortcutsAction) -> Bool {
        let actionURL = shortcutsDirectory.appendingPathComponent("\(action.name).shortcut")
        
        do {
            let actionData = try action.toData()
            try actionData.write(to: actionURL)
            print("✓ Shortcuts action installed: \(action.name)")
            return true
        } catch {
            print("✗ Failed to install Shortcuts action: \(error.localizedDescription)")
            return false
        }
    }
    
    func installAllActions() {
        print("Installing FocusCTL Shortcuts actions...")
        print("========================================")
        
        let actions = [
            createWorkAction(),
            createPersonalAction(),
            createSleepAction(),
            createPresentationAction(),
            createFocusModeAction(for: .gaming),
            createFocusModeAction(for: .driving),
            createFocusModeAction(for: .fitness),
            createFocusModeAction(for: .mindfulness),
            createFocusModeAction(for: .reading),
            createFocusModeAction(for: .writing),
            createFocusModeAction(for: .research),
            createFocusModeAction(for: .creative),
            createFocusModeAction(for: .social),
            createFocusModeAction(for: .family),
            createFocusModeAction(for: .friends)
        ]
        
        var successCount = 0
        for action in actions {
            if installAction(action) {
                successCount += 1
            }
        }
        
        print()
        print("Installation complete: \(successCount)/\(actions.count) actions installed")
        
        if successCount > 0 {
            print()
            print("You can now use these actions in Shortcuts app:")
            print("1. Open Shortcuts app")
            print("2. Look for 'FocusCTL' actions in the library")
            print("3. Add them to your workflows or use them directly")
        }
    }
    
    func uninstallAllActions() {
        print("Uninstalling FocusCTL Shortcuts actions...")
        
        do {
            let files = try FileManager.default.contentsOfDirectory(at: shortcutsDirectory, includingPropertiesForKeys: nil)
            let focusctlActions = files.filter { $0.lastPathComponent.contains("FocusCTL") }
            
            for actionURL in focusctlActions {
                try FileManager.default.removeItem(at: actionURL)
                print("✓ Removed: \(actionURL.lastPathComponent)")
            }
            
            print("All FocusCTL actions uninstalled")
        } catch {
            print("Error uninstalling actions: \(error.localizedDescription)")
        }
    }
    
    private func getIconForMode(_ mode: FocusMode) -> String {
        switch mode {
        case .work: return "briefcase.fill"
        case .personal: return "person.fill"
        case .sleep: return "moon.fill"
        case .presentation: return "presentation.fill"
        case .gaming: return "gamecontroller.fill"
        case .driving: return "car.fill"
        case .fitness: return "figure.walk"
        case .mindfulness: return "leaf.fill"
        case .reading: return "book.fill"
        case .writing: return "pencil.fill"
        case .research: return "magnifyingglass"
        case .creative: return "paintbrush.fill"
        case .social: return "person.2.fill"
        case .family: return "house.fill"
        case .friends: return "person.3.fill"
        }
    }
}

// MARK: - Shortcuts Action Model

struct ShortcutsAction {
    let identifier: String
    let name: String
    let description: String
    let script: String
    let icon: String
    
    func toData() throws -> Data {
        let actionDict: [String: Any] = [
            "WFWorkflowActions": [
                [
                    "WFWorkflowActionIdentifier": "is.workflow.actions.runsshscript",
                    "WFWorkflowActionParameters": [
                        "WFSSHHost": "localhost",
                        "WFSSHPort": "22",
                        "WFSSHUser": NSUserName(),
                        "WFSSHScript": script
                    ]
                ]
            ],
            "WFWorkflowInputContentItemClasses": [
                "WFStringContentItem"
            ],
            "WFWorkflowTypes": [
                "NCWidget",
                "WatchKit",
                "Shortcuts"
            ],
            "WFWorkflowClientVersion": "900",
            "WFWorkflowMinimumClientVersion": 900,
            "WFWorkflowIcon": [
                "WFWorkflowIconImageData": icon,
                "WFWorkflowIconStartColor": 0xFF6B35,
                "WFWorkflowIconGlyphNumber": 0
            ],
            "WFWorkflowHasShortcutInputVariables": false,
            "WFWorkflowImportQuestions": [],
            "WFWorkflowInputPassthrough": false,
            "WFWorkflowNoInputBehavior": "Ask",
            "WFWorkflowActionCount": 1
        ]
        
        return try JSONSerialization.data(withJSONObject: actionDict, options: .prettyPrinted)
    }
}

// MARK: - Command Line Integration

extension ShortcutsActionManager {
    
    static func handleShortcutsCommand(_ arguments: [String]) {
        let manager = ShortcutsActionManager()
        
        guard arguments.count > 2 else {
            print("Error: Missing shortcuts command")
            print("Usage: focusctl shortcuts [install|uninstall|list]")
            exit(1)
        }
        
        let command = arguments[2]
        
        switch command {
        case "install":
            manager.installAllActions()
        case "uninstall":
            manager.uninstallAllActions()
        case "list":
            manager.listInstalledActions()
        default:
            print("Error: Unknown shortcuts command '\(command)'")
            print("Usage: focusctl shortcuts [install|uninstall|list]")
            exit(1)
        }
    }
    
    private func listInstalledActions() {
        print("Installed FocusCTL Shortcuts actions:")
        print("====================================")
        
        do {
            let files = try FileManager.default.contentsOfDirectory(at: shortcutsDirectory, includingPropertiesForKeys: nil)
            let focusctlActions = files.filter { $0.lastPathComponent.contains("FocusCTL") }
            
            if focusctlActions.isEmpty {
                print("No FocusCTL actions installed")
                print("Run 'focusctl shortcuts install' to install actions")
            } else {
                for actionURL in focusctlActions {
                    print("• \(actionURL.lastPathComponent)")
                }
            }
        } catch {
            print("Error listing actions: \(error.localizedDescription)")
        }
    }
}