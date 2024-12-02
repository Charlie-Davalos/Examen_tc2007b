//
//  CovidService.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import Foundation
import Alamofire

/// Servicio para realizar solicitudes a la API de COVID
class CovidService {
    private let apiKey = "GvW+LZ4VmT0kE9TUaaUInA==xDRx5TSYr1hEEaUq"
    private let baseURL = "https://api.api-ninjas.com/v1/covid19"
    
    /// Realiza la solicitud a la API para un país específico
    func fetchCovidData(for country: String, completion: @escaping (Result<CovidData, Error>) -> Void) {
        let url = "\(baseURL)?country=\(country)"
        
        print("[INFO] URL generada correctamente: \(url)")
        
        // Usando Alamofire para realizar la solicitud
        AF.request(url, method: .get, headers: ["X-Api-Key": apiKey]).responseData { response in
            switch response.result {
            case .success(let data):
                print("[INFO] Datos crudos recibidos: \(String(data: data, encoding: .utf8) ?? "Datos no legibles")")
                
                do {
                    // Aquí se usa el modelo adecuado con el diccionario de fechas como claves
                    let covidData = try JSONDecoder().decode([CovidData].self, from: data)
                    print("[SUCCESS] Datos decodificados exitosamente: \(covidData)")
                    completion(.success(covidData.first!))  // Tomamos el primer elemento de la respuesta
                } catch {
                    print("[ERROR] Error al decodificar datos: \(error.localizedDescription)")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("[ERROR] Error de red: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
