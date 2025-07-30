//
//  ErrorHandling.swift
//
//  Created by chetu on 29/09/22.
//

import Foundation


enum THhttpError: Int {
    // 200 Success
    case success = 200

    // 400 Client Error
    case badRequest = 400

    case tokenExpire = 401

    case badAuthorisation =  404

    // 500 Server Error
    case internalServerError = 500

    case couldNotConnectToServer = 1004

    func getDescription() -> String {
        switch self {
        case .badRequest:
            return NSLocalizedString("Handle400", comment: "Please handle Bad request error.")
        case .success:
            return "Sucess"
        case .internalServerError:
            return "internal Server error"
        case .couldNotConnectToServer:
            return "could not connect to server"
        case .badAuthorisation:
            return "Bad request"
        case .tokenExpire:
            return "expired token"
        }
    }
}

func handleError(statusCode: Int) -> Bool {
    if let err = THhttpError(rawValue: statusCode)?.getDescription() {
        if err == "expired token" {
            return true
        }
        return false
    }
    return false
}
