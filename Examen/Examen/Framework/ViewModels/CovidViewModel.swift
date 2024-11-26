//
//  CovidViewModel.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//


import Foundation
import SwiftUI

class CovidViewModel: ObservableObject {
    @Published var covidData: [CovidData] = []
    @Published var errorMessage: CovidViewModel.ErrorMessage? = nil
    
    struct ErrorMessage: Identifiable {
        let id = UUID()
        let message: String
    }

    func loadCovidData() {
        print("[INFO] Iniciando carga de datos de COVID...")
        
        let service = CovidService()
        service.fetchCovidData { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print("[SUCCESS] Datos cargados exitosamente:", data)
                    self.covidData = data
                case .failure(let error):
                    print("[ERROR] Error durante la carga de datos:", error.localizedDescription)
                    self.errorMessage = ErrorMessage(message: "Error al cargar los datos: \(error.localizedDescription)")
                }
            }
        }
    }
}
