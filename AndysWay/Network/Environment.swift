//
//  Environment.swift
//  AndysWay
//
//  Created by Christian Grise on 10/2/24.
//

import Foundation

// Define an enum for environment types
public enum EnvironmentType {
    case development
    case staging
    case production
    
    var url: URL {
        switch self {
        case .development: return URL(string: "http://localhost:3000")!
        case .staging: return URL(string: "https://staging.api.example.com")!
        case .production: return URL(string: "https://production.api.example.com")!
        }
    }
}

// Define a protocol for environment configuration
public protocol EnvironmentConfig {
    var environmentType: EnvironmentType { get }
    var apiBaseURL: URL { get }
    var loggingEnabled: Bool { get }
    var timeoutInterval: TimeInterval { get }
}

//MARK: - Development environment configuration
public struct DevelopmentConfig: EnvironmentConfig {
    public var environmentType: EnvironmentType {
        return .development
    }
    
    public var apiBaseURL: URL {
        return environmentType.url
    }
    
    public var loggingEnabled: Bool {
        return true
    }
    
    public var timeoutInterval: TimeInterval {
        return 30.0
    }
}

//MARK: - Staging environment configuration
public struct StagingConfig: EnvironmentConfig {
    public var environmentType: EnvironmentType {
        return .staging
    }
    
    public var apiBaseURL: URL {
        return environmentType.url
    }
    
    public var loggingEnabled: Bool {
        return true
    }
    
    public var timeoutInterval: TimeInterval {
        return 20.0
    }
}

//MARK: - Production environment configuration
public struct ProductionConfig: EnvironmentConfig {
    public var environmentType: EnvironmentType {
        return .production
    }
    
    public var apiBaseURL: URL {
        return environmentType.url
    }
    
    public var loggingEnabled: Bool {
        return false
    }
    
    public var timeoutInterval: TimeInterval {
        return 15.0
    }
}

public func configureApp(for environment: EnvironmentConfig) {
    print("Current Environment: \(environment.environmentType)")
    print("API Base URL: \(environment.apiBaseURL)")
    print("Logging Enabled: \(environment.loggingEnabled)")
    print("Timeout Interval: \(environment.timeoutInterval) seconds")
}
