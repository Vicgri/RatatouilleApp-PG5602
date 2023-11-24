//
//  StringExtensions.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-22.
//

import Foundation

extension String {
    
    func transformCountryName() -> String {
        switch self {
        case "American":    return "US"
        case "British":     return "GB"
        case "Canadian":    return "CA"
        case "Chinese":     return "CN"
        case "Croatian":    return "HR"
        case "Dutch":       return "NL"
        case "Egyptian":    return "EG"
        case "French":      return "FR"
        case "Greek":       return "GR"
        case "Indian":      return "IN"
        case "Irish":       return "IE"
        case "Italian":     return "IT"
        case "Jamaican":    return "JM"
        case "Japanese":    return "JP"
        case "Malaysian":   return "MY"
        case "Mexican":     return "MX"
        case "Moroccan":    return "MO"
        case "Polish":      return "PL"
        case "Russian":     return "RU"
        case "Thai":        return "TH"
        case "Tunisian":    return "TN"
        case "Spanish":     return "ES"
        case "Portuguese":  return "PT"
        case "Kenyan":      return "KE"
        case "Vietnamese":  return "VN"
        case "Turkish":     return "TR"
        default:            return ""
        }
    }
}
