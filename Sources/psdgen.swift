// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation

@main
struct psdgen: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Generate a secure password", version: "0.0.1")
    
    @Argument(help: "Specified length") var length: Int = 8
    
    @Flag(name: .short, help: "Include uppercase letters") var upperCase = false
    @Flag(name: .short, help: "Include symbol characters") var symbols = false
    @Flag(name: .short, help: "Include numbers") var numbers = false
    
    mutating func run() throws {
        let ucase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lcase = ucase.lowercased()
        let num = "0123456789"
        let sym = "!@#$%^&*"
        var password = ""
        
        // Ensure we have at least one character of each requested type
        if upperCase && length > 0 {
            password += String(ucase.randomElement()!)
        }
        if numbers && length > password.count {
            password += String(num.randomElement()!)
        }
        if symbols && length > password.count {
            password += String(sym.randomElement()!)
        }
        
        // Fill the rest with the character pool approach
        var charPool = lcase // Always include lowercase letters as base
        if upperCase { charPool += ucase }
        if numbers { charPool += num }
        if symbols { charPool += sym }
        
        // Fill remaining positions to reach requested length
        while password.count < length {
            if let randomChar = charPool.randomElement() {
                password += String(randomChar)
            }
        }
        
        // Shuffle to randomize the positions of the guaranteed characters
        password = String(password.shuffled())
        
        print("Generated password: \(password)")
    }
}
