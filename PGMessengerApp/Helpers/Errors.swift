//
//  ServerError.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 15/03/2021.
//

import SwiftUI

public enum ServerError: Error {
    case transportError(Error)
    case serverSideError(Int)
    case badRequest(String)
    case noData
    case jsonDecodeFailed(String)
    case duplicate(String)
    case conflict(String)
    case unauthorised
    case unknown
}

extension ServerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .transportError(let error):
            return NSLocalizedString("\(error.localizedDescription)", comment: "Transport Error")
        case .serverSideError(let number):
            return NSLocalizedString("Status Code \(number)", comment: "Server Side Error")
        case .badRequest(let request):
            return NSLocalizedString("\(request.description)", comment: "Bad Request")
        case .noData:
            return NSLocalizedString("No data has been returned", comment: "No data")
        case .jsonDecodeFailed(let json):
            return NSLocalizedString("JSON (\(json)) not decoded", comment: "JSON not decoded")
        case .duplicate(let duplicate):
            return NSLocalizedString("\(duplicate)", comment: "Reason user could not be created")
        case .conflict(let conflict):
            return NSLocalizedString("\(conflict)", comment: "Reason user could not be created")
        case .unauthorised:
            return NSLocalizedString("Unauthorised", comment: "Unauthorised")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
