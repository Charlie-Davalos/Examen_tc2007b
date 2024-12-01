//
//  CovidRepository.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 01/12/24.
//

import Foundation

/// Repositorio para manejar la lógica de negocio entre el servicio y el ViewModel
class CovidRepository {
    private let service = CovidService()
    
    /// Obtiene datos de COVID para una lista de países
    func getCovidData(for countries: [String], completion: @escaping (Result<[CovidData], Error>) -> Void) {
        var results: [CovidData] = []
        var errors: [Error] = []
        let group = DispatchGroup()
        
        for country in countries {
            group.enter()
            service.fetchCovidData(for: country) { result in
                switch result {
                case .success(let data):
                    results.append(data)
                case .failure(let error):
                    errors.append(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if errors.isEmpty {
                completion(.success(results))
            } else {
                completion(.failure(NSError(domain: "Some requests failed", code: 0, userInfo: nil)))
            }
        }
    }
}
