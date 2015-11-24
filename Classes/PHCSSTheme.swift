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
    private var sources: [String] = []
    private var styleConfigurations: [String: IPHStyleConfiguration] = [:]
    
}

// MARK:- Loading CSS themes from sources using settings
public extension PHCSSTheme {
    public func loadStyleConfigurationUsingSettings(settingsDictionary: [String: AnyObject]) throws {
        let settings = Settings(dictionary: settingsDictionary)
        var sources = NSBundle.mainBundle().pathsForResourcesOfType("css", inDirectory: settings.directory)
        
        sources.sortInPlace { (element, _) in
            if element.containsString(settings.variablesFilename) {
                return true
            } else {
                return false
            }
        }
        
        for sourceFilePath in sources {
            try loadStyleConfigurationsFromFile(sourceFilePath)
        }
    }
    
    public func loadStyleConfigurationsFromFile(filePath: String) throws {
        let configurations = try parser.parseFromFile(filePath)
        for (key, configuration) in configurations {
            styleConfigurations[key] = configuration
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