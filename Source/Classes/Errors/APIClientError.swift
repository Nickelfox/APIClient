//
//  APIClientError.swift
//  APIClient
//
//  Created by Ravindra Soni on 16/12/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import Foundation
import SwiftyJSON

fileprivate struct ErrorDefaults {
	static let domain = "Error"
	static let message = "An unknown error has occured."
}

fileprivate enum ErrorCode: Int {
	case noInternet = 5555
	case errorReadingFile = 5556
	case unknown = 5557
	
	var code: Int {
		return self.rawValue
	}
}

enum APIClientError: AnyError {
	
	case noInternet
	case errorReadingFile(URL)
	case unknown
	
	var code: Int {
		switch self {
		case .noInternet: return ErrorCode.noInternet.code
		case .errorReadingFile: return ErrorCode.errorReadingFile.code
		case .unknown: return ErrorCode.unknown.code
		}
	}

	var domain: String {
		return ErrorDefaults.domain
	}
	
	var message: String {
		var message = ErrorDefaults.message
		switch self {
		case .noInternet:
			message = "No Internet Connection! Check your internet connection."
		case .errorReadingFile(let fileUrl):
			message = "Error reading file: \(fileUrl.absoluteString)"
		case .unknown: break
		}
		return message
	}

}
