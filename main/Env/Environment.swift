//
//  Environment.swift
//  main
//
//  Created by Matheus Lima Gomes on 15/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

public final class Environment {
public enum EnvironmentVariables: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    public static func variable(_ named: EnvironmentVariables) -> String {
        return Bundle.main.infoDictionary![named.rawValue] as! String
    }
}
