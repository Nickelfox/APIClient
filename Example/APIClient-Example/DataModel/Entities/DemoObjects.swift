//
//  DemoObject.swift
//  APIClient-Example
//
//  Created by Ravindra Soni on 06/01/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import JSONParsing
import APIClient

enum Test: Int, JSONParseRawRepresentable {
	typealias RawValue = Int
	case one = 1
	case two = 2
}

public struct DemoObject: CustomStringConvertible {
	let value: Test
	
	public var description: String {
		return "value: \(self.value)"
	}
}

extension DemoObject: JSONParseable {
	public static func parse(_ json: JSON) throws -> DemoObject {
		return try DemoObject(
			value: json["id"]^
		)
	}
	
	func test() {

	}
}

struct PaginationMetaData: PageMetaData {
	static func parse(_ json: JSON) throws -> PaginationMetaData {
		return PaginationMetaData()
	}
}

public struct Number: Pageable {
	var value: Int
	
	public static func parse(_ json: JSON) throws -> Number {
		return try Number(
			value: json^
		)
	}
	
	public static func fetch(router: PageRouter, completion: @escaping (APIResult<PageResponse>) -> Void) {
		NonAuthAPIClient.shared.request(router, completion: completion)
	}
	
//	public static func fetch<U, V>(pageInfo: PageInfo1<V>, completion: @escaping (APIResult<U>) -> Void) where U : PaginationResponseProtocol, V : JSONParseable {
//		
//	}

	public static func fetch(router: Router, completion: @escaping (APIResult<[Number]>) -> Void) {
		NonAuthAPIClient.shared.request(router) { (result: APIResult<ListResponse<Number>>) in
			switch result {
			case .success(let listResponse):
				completion(.success(listResponse.list))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
}
