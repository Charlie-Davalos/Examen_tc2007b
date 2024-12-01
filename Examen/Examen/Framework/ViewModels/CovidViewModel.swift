//
//  CovidViewModel.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import Foundation
import SwiftUI

/// ViewModel que conecta los datos de COVID con la vista
class CovidViewModel: ObservableObject, CovidRequirement {
    @Published var covidData: [CovidData] = []
    @Published var errorMessage: ErrorMessage? = nil
    
    struct ErrorMessage: Identifiable {
        let id = UUID()
        let message: String
    }
    
    private let repository = CovidRepository()
    
    /// Carga los datos de COVID desde el repositorio
    func loadCovidData() {
        print("[INFO] Iniciando carga de datos en ViewModel...")
        repository.getCovidData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print("[SUCCESS] Datos recibidos en ViewModel: \(data)")
                    self?.covidData = data
                case .failure(let error):
                    print("[ERROR] Error en ViewModel: \(error.localizedDescription)")
                    self?.errorMessage = ErrorMessage(message: "Error al cargar los datos: \(error.localizedDescription)")
                }
            }
        }
    }
}
