//
//  PHCSSParser.swift
//  PHCSSTheme
//
//  Created by Sergey on 22.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation

class PHCSSParser: PHCSSParserProtocol {
    private var forwardValues = [String: String]()
    
    func parseFromFile(filePath: String) throws -> [String: PHStyleConfiguration] {
        let originalCssContent = try! String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
        let cssContent = convertedCSSContent(originalCssContent)
        let styles = cssContent.componentsSeparatedByString("\n")
        
        var styleConfigurations: [String: PHStyleConfiguration] = [:]
        
        for styleString in styles {
            if styleString.isEmpty {
                continue
            }
            
            // Get style name
            if let styleNameEnd = styleString.rangeOfString("{") {
                let styleName = styleString.substringToIndex(styleNameEnd.startIndex)
                let properties = styleString.substringFromIndex(styleNameEnd.endIndex)
                
                if styleName.characters.first == "@" {
                    // Parse forward value
                    forwardValues[styleName] = propertiesByRemoveExcessiveCharacters(properties)
                } else {
                    let styleConfiguration = try styleConfigurationForProperties(properties)
                    if !styleConfiguration.isEmpty {
                        styleConfigurations[styleName] = styleConfiguration
                    }
                }
            } else {
                throw PHCSSParserError.WrongStyleFormat(style: styleString)
            }
        }
        
        return styleConfigurations
    }
    
    private func styleConfigurationForProperties(properties: String) throws -> PHStyleConfiguration {
        let propertiesArray = propertiesByRemoveExcessiveCharacters(properties).componentsSeparatedByString(";")
        var values: [String: String] = [:]
        for elementString in propertiesArray {
            if elementString.isEmpty {
                continue
            }
            
            let property = elementString.componentsSeparatedByString(":")
            if property.count == 2 {
                let key = property[0]
                let value = valueWithReplacedForwardValue(property[1])
                if let value = value {
                    values[key] = value
                }
            } else {
                throw PHCSSParserError.WrongStylePropertyFormat(property: elementString)
            }
        }
        
        return PHStyleConfiguration(values: values)
    }
    
    private func valueWithReplacedForwardValue(value: String) -> String? {
        let forwardValueStartIndex = value.rangeOfString("@")?.startIndex
        
        if let startIndex = forwardValueStartIndex {
            let searchRange = startIndex...value.endIndex.predecessor()
            let endOfForwardValueIndex = value.rangeOfString("-", range: searchRange)?.startIndex
            let key = endOfForwardValueIndex != nil ? value.substringWithRange(startIndex...endOfForwardValueIndex!.predecessor()) : value.substringFromIndex(startIndex)
            
            if let valueForKey = forwardValues[key] {
                return value.stringByReplacingOccurrencesOfString(key, withString: valueForKey)
            } else {
                print("CSS Parser error: Undeclared forward value: \(key)")
                return nil
            }
        } else {
            return value
        }
    }
    
    private func propertiesByRemoveExcessiveCharacters(properties: String) -> String {
        return properties.stringByReplacingOccurrencesOfString("}:", withString: "").componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "{}")).joinWithSeparator("")
    }
    
    private func convertedCSSContent(cssContent: String) -> String {
        let convertedContent = cssContent.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: " \t\n\r")).joinWithSeparator("")
        return convertedContent.stringByReplacingOccurrencesOfString("}", withString: "}\n")
    }
}