//
//  PHCSSParserProtocol.swift
//  PHCSSTheme
//
//  Created by Sergey on 22.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation

protocol PHCSSParserProtocol {
    func parseFromFile(filePath: String) throws -> [String: IPHStyleConfiguration]
}
