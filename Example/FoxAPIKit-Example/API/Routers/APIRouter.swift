//
//  APIRouter.swift
//  Inito
//
//  Created by Ravindra Soni on 24/10/16.
//  Copyright © 2016 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

enum APIRouter: Router {
	
	case user
	case userError

	var keypathToMap: String? {
		switch self {
		case .user, .userError:
			return "args"
		}
	}
	
	var timeoutInterval: TimeInterval? {
		return nil
	}
	
	var encoding: URLEncoding? {
		return nil
	}
	
	public var method: HTTPMethod {
		switch self {
		case .user, .userError:
			return .get
		}
	}
	
	public var path: String {
		switch self {
		case .user, .userError:
			return "/get"
		}
	}
	
	public var params: [String: Any] {
		switch self {
		case .user:
			return ["name":"Fox"]
		case .userError:
			return ["error":"Example Error"]
		}
	}
		
	public var baseUrl: URL {
		let baseURL = URL(string: "https://httpbin.org")!
		return baseURL
	}
	
	public var headers: [String: String] {
		return ["Content-Type": "application/json"]
	}
	
}

