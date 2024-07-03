//
//  LoanService.swift
//  SamirAssignment
//
//  Created by Zakki Mudhoffar on 02/07/24.
//

import Foundation
import Combine

protocol LoanService {
    func fetchLoan() -> AnyPublisher<[LoanModel], Error>
    func fetchDocument(urlString: String) -> AnyPublisher<Data, Error>
}

class APIService: LoanService {
    private let baseUrl = URL(string: "https://raw.githubusercontent.com/andreascandle/p2p_json_test/main")!

    func fetchLoan() -> AnyPublisher<[LoanModel], Error> {
        let endPoint = "api/json/loans.json"
        guard var urlComponents = URLComponents(url: baseUrl.appendingPathComponent(endPoint), resolvingAgainstBaseURL: true) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [LoanModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    
    func fetchDocument(urlString: String) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: urlString, relativeTo: baseUrl) else {
                    return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
                }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .eraseToAnyPublisher()
    }
}
