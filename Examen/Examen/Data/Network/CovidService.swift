//
//  CovidService.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import Foundation

/// Servicio para realizar solicitudes a la API de COVID
class CovidService {
    private let apiKey = "GvW+LZ4VmT0kE9TUaaUInA==xDRx5TSYr1hEEaUq"
    private let baseURL = "https://api.api-ninjas.com/v1/covid19?country=Mexico"
    
    /// Realiza la solicitud a la API y devuelve los datos decodificados
    func fetchCovidData(completion: @escaping (Result<[CovidData], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            print("[ERROR] URL inválida")
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        print("[INFO] URL generada correctamente: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("[ERROR] Error de red: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("[ERROR] No se recibieron datos de la API")
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            print("[INFO] Datos crudos recibidos: \(String(data: data, encoding: .utf8) ?? "Datos no legibles")")
            
            do {
                let covidData = try JSONDecoder().decode([CovidData].self, from: data)
                print("[SUCCESS] Datos decodificados exitosamente: \(covidData)")
                completion(.success(covidData))
            } catch {
                print("[ERROR] Error al decodificar datos: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
