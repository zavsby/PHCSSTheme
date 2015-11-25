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

