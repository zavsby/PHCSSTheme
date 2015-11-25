//
//  PHCSSTheme.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

public class PHCSSTheme {
    public static let sharedTheme = PHCSSTheme()
    private init() {}
    
    private let parser: PHCSSParserProtocol = PHCSSParser()
    private var styleConfigurations: [String: IPHStyleConfiguration] = [:]
    
}

// MARK:- Class quick access methods
public extension PHCSSTheme {
    public class func styleConfigurationForKey(key: String) -> IPHStyleConfiguration {
        return try! sharedTheme.styleConfigurationForKey(key)
    }
    
    public class func applyStyleToView(view: UIView, keys: String) {
        try! sharedTheme.applyStyleToView(view, keys: keys)
    }
}

// MARK:- Applying styles to views
public extension PHCSSTheme {
    public func applyStyleToView(view: UIView, styleConfiguration: IPHStyleConfiguration) {
        let styleManager = PHStyleManagerFactory.styleManagerForView(view)
        styleManager.applyStyle(styleConfiguration)
    }
    
    public func applyStyleToView(view: UIView, keys: String) throws {
        let styleConfiguration = try styleConfigurationForKey(keys)
        applyStyleToView(view, styleConfiguration: styleConfiguration)
    }
}

// MARK:- Gettings merged style configuration from styles string
public extension PHCSSTheme {
    public func styleConfigurationForKey(key: String) throws -> IPHStyleConfiguration {
        let styleKeys = key.componentsSeparatedByString(" ").joinWithSeparator("").componentsSeparatedByString(",")
        var styles = [IPHStyleConfiguration]()
        for key in styleKeys {
            if let style = styleConfigurations[key] {
                styles.append(style)
            } else {
                throw PHCSSThemeError.StyleNotFound(key: key)
            }
        }
        
        if styles.count == 1 {
            return styles[0]
        } else if styles.count > 1 {
            var previousConfiguration = styles[0]
            for index in (1..<styles.count) {
                previousConfiguration = previousConfiguration.mergedConfigurationWithConfiguration(styles[index])
            }
            
            return previousConfiguration
        } else {
            throw PHCSSThemeError.EmptyStyleKeysString
        }
    }
}

// MARK:- Loading CSS themes from sources using settings
public extension PHCSSTheme {
    public func loadStyleConfigurationUsingSettings(settingsDictionary: [String: AnyObject]) throws {
        let settings = Settings(dictionary: settingsDictionary)
        var sources = NSBundle.mainBundle().pathsForResourcesOfType("css", inDirectory: settings.directory)
        
        let variablesFilepathIndex = sources.indexOf { return $0.containsString(settings.variablesFilename) }
        if let index = variablesFilepathIndex where index != 0 {
            let filePath = sources[index]
            sources.removeAtIndex(index)
            sources.insert(filePath, atIndex: 0)
        }
        
        for sourceFilePath in sources {
            try loadStyleConfigurationsFromFile(sourceFilePath)
        }
        
        print("PHCSSTheme: loaded \(sources.count) CSS sources")
    }
    
    public func loadStyleConfigurationsFromFile(filePath: String) throws {
        let configurations = try parser.parseFromFile(filePath)
        for (key, configuration) in configurations {
            if styleConfigurations[key] == nil {
                styleConfigurations[key] = configuration
            } else {
                print("PHCSSTheme warning: style with key \(key) is already loaded. Skipping.")
            }
        }
    }
    
    private struct Settings {
        let directory: String
        let variablesFilename: String
        
        init(dictionary: [String: AnyObject]) {
            self.directory = dictionary[Settings.DirectoryKey] as! String
            self.variablesFilename = dictionary[Settings.VariablesFilenameKey] as! String
        }
        
        private static let DirectoryKey = "directory"
        private static let VariablesFilenameKey = "variablesFilename"
    }
}

