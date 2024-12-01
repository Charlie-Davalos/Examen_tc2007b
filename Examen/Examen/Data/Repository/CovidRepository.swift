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
    
    /// Obtiene datos de COVID desde el servicio
    func getCovidData(completion: @escaping (Result<[CovidData], Error>) -> Void) {
        print("[INFO] Iniciando obtención de datos desde el servicio...")
        service.fetchCovidData { result in
            switch result {
            case .success(let data):
                print("[SUCCESS] Datos obtenidos del servicio: \(data)")
                completion(.success(data))
            case .failure(let error):
                print("[ERROR] Error desde el servicio: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
