//
//  DarkSkyError.swift
//  Stormy
//
//  Created by Ernest Fan on 2017-07-04.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

enum DarkSkyError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case invalidUrl
    case jsonParsingFailure
}

extension DarkSkyError {
    func getErrorDetail() -> String {
        switch(self){
        case .requestFailed: return "HTTP Request Failed"
        case .responseUnsuccessful: return "HTTP Unsuccessful Response"
        case .invalidData: return "Invalid Data Format"
        case .jsonConversionFailure: return "Data Conversion Failed"
        case .invalidUrl: return "Invalid URL/Coordination"
        case .jsonParsingFailure: return "JSON Data Parsing Failure"
        }
    }
}
