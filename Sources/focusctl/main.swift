#!/usr/bin/env swift

import Foundation
import AppKit

// MARK: - Command Line Interface

struct FocusCTL {
    private let focusManager = FocusManager()
    
    func run() {
        let arguments = CommandLine.arguments
        
        guard arguments.count > 1 else {
            listModes()
            return
        }
        
        let command = arguments[1]
        
        switch command {
        case "work":
            handleWorkCommand(arguments)
        case "personal":
            handlePersonalCommand(arguments)
        case "sleep":
            handleSleepCommand(arguments)
        case "presentation":
            handlePresentationCommand(arguments)
        case "gaming":
            handleGamingCommand(arguments)
        case "driving":
            handleDrivingCommand(arguments)
        case "fitness":
            handleFitnessCommand(arguments)
        case "mindfulness":
            handleMindfulnessCommand(arguments)
        case "reading":
            handleReadingCommand(arguments)
        case "writing":
            handleWritingCommand(arguments)
        case "research":
            handleResearchCommand(arguments)
        case "creative":
            handleCreativeCommand(arguments)
        case "social":
            handleSocialCommand(arguments)
        case "family":
            handleFamilyCommand(arguments)
        case "friends":
            handleFriendsCommand(arguments)
        case "shortcuts":
            ShortcutsActionManager.handleShortcutsCommand(arguments)
        case "help", "-h", "--help":
            showHelp()
        case "version", "-v", "--version":
            showVersion()
        default:
            print("Error: Unknown focus mode '\(command)'")
            print("Run 'focusctl help' for available commands.")
            exit(1)
        }
    }
    
    private func handleWorkCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for work mode")
            print("Usage: focusctl work [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.work, enabled: true)
        case "off":
            focusManager.setFocusMode(.work, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.work)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl work [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handlePersonalCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for personal mode")
            print("Usage: focusctl personal [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.personal, enabled: true)
        case "off":
            focusManager.setFocusMode(.personal, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.personal)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl personal [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleSleepCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for sleep mode")
            print("Usage: focusctl sleep [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.sleep, enabled: true)
        case "off":
            focusManager.setFocusMode(.sleep, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.sleep)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl sleep [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handlePresentationCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for presentation mode")
            print("Usage: focusctl presentation [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.presentation, enabled: true)
        case "off":
            focusManager.setFocusMode(.presentation, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.presentation)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl presentation [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleGamingCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for gaming mode")
            print("Usage: focusctl gaming [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.gaming, enabled: true)
        case "off":
            focusManager.setFocusMode(.gaming, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.gaming)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl gaming [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleDrivingCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for driving mode")
            print("Usage: focusctl driving [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.driving, enabled: true)
        case "off":
            focusManager.setFocusMode(.driving, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.driving)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl driving [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleFitnessCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for fitness mode")
            print("Usage: focusctl fitness [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.fitness, enabled: true)
        case "off":
            focusManager.setFocusMode(.fitness, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.fitness)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl fitness [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleMindfulnessCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for mindfulness mode")
            print("Usage: focusctl mindfulness [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.mindfulness, enabled: true)
        case "off":
            focusManager.setFocusMode(.mindfulness, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.mindfulness)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl mindfulness [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleReadingCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for reading mode")
            print("Usage: focusctl reading [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.reading, enabled: true)
        case "off":
            focusManager.setFocusMode(.reading, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.reading)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl reading [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleWritingCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for writing mode")
            print("Usage: focusctl writing [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.writing, enabled: true)
        case "off":
            focusManager.setFocusMode(.writing, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.writing)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl writing [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleResearchCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for research mode")
            print("Usage: focusctl research [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.research, enabled: true)
        case "off":
            focusManager.setFocusMode(.research, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.research)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl research [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleCreativeCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for creative mode")
            print("Usage: focusctl creative [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.creative, enabled: true)
        case "off":
            focusManager.setFocusMode(.creative, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.creative)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl creative [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleSocialCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for social mode")
            print("Usage: focusctl social [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.social, enabled: true)
        case "off":
            focusManager.setFocusMode(.social, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.social)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl social [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleFamilyCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for family mode")
            print("Usage: focusctl family [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.family, enabled: true)
        case "off":
            focusManager.setFocusMode(.family, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.family)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl family [on|off|toggle]")
            exit(1)
        }
    }
    
    private func handleFriendsCommand(_ arguments: [String]) {
        guard arguments.count > 2 else {
            print("Error: Missing action for friends mode")
            print("Usage: focusctl friends [on|off|toggle]")
            exit(1)
        }
        
        let action = arguments[2]
        switch action {
        case "on":
            focusManager.setFocusMode(.friends, enabled: true)
        case "off":
            focusManager.setFocusMode(.friends, enabled: false)
        case "toggle":
            focusManager.toggleFocusMode(.friends)
        default:
            print("Error: Invalid action '\(action)'")
            print("Usage: focusctl friends [on|off|toggle]")
            exit(1)
        }
    }
    
    private func listModes() {
        print("FocusCTL - macOS Focus Mode Controller")
        print("=====================================")
        print()
        
        let modes = focusManager.getAllFocusModes()
        
        if modes.isEmpty {
            print("No focus modes available.")
            return
        }
        
        print("Available focus modes:")
        print()
        
        for mode in modes {
            let status = mode.isEnabled ? "ON" : "OFF"
            let statusColor = mode.isEnabled ? "\u{001B}[32m" : "\u{001B}[31m" // Green or Red
            let resetColor = "\u{001B}[0m"
            
            print("  \(mode.name): \(statusColor)\(status)\(resetColor)")
        }
        
        print()
        print("Usage: focusctl <mode> [on|off|toggle]")
        print("Example: focusctl work on")
        print()
        print("Run 'focusctl help' for more information.")
    }
    
    private func showHelp() {
        print("FocusCTL - macOS Focus Mode Controller")
        print("=====================================")
        print()
        print("USAGE:")
        print("    focusctl <mode> [on|off|toggle]")
        print("    focusctl [help|version]")
        print()
        print("COMMANDS:")
        print("    work         Work focus mode")
        print("    personal     Personal focus mode")
        print("    sleep        Sleep focus mode")
        print("    presentation Presentation focus mode")
        print("    gaming       Gaming focus mode")
        print("    driving      Driving focus mode")
        print("    fitness      Fitness focus mode")
        print("    mindfulness  Mindfulness focus mode")
        print("    reading      Reading focus mode")
        print("    writing      Writing focus mode")
        print("    research     Research focus mode")
        print("    creative     Creative focus mode")
        print("    social       Social focus mode")
        print("    family       Family focus mode")
        print("    friends      Friends focus mode")
        print("    shortcuts    Manage Shortcuts app actions")
        print()
        print("ACTIONS:")
        print("    on           Turn focus mode on")
        print("    off          Turn focus mode off")
        print("    toggle       Toggle focus mode state")
        print()
        print("OPTIONS:")
        print("    help, -h, --help     Show this help message")
        print("    version, -v, --version  Show version information")
        print()
        print("EXAMPLES:")
        print("    focusctl work on")
        print("    focusctl presentation off")
        print("    focusctl sleep toggle")
        print("    focusctl                    # List all modes")
        print("    focusctl shortcuts install  # Install Shortcuts actions")
        print()
        print("For more information, visit: https://github.com/makalin/focusctl")
    }
    
    private func showVersion() {
        print("FocusCTL version 1.0.0")
        print("Copyright (c) 2025 Mehmet T. AKALIN")
        print("MIT License")
    }
}

// MARK: - Main Entry Point

let focusctl = FocusCTL()
focusctl.run()