//
//  CountryViewModel.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 01/12/24.
//

import Foundation

// ViewModel para manejar los datos de un país específico
class CountryViewModel: ObservableObject {
    @Published var covidData: CovidData?
    
    private let service = CovidService()
    
    func loadCovidData(for country: String) {
        service.fetchCovidData(for: country) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.covidData = data
                case .failure(let error):
                    print("[ERROR] Error al cargar los datos: \(error.localizedDescription)")
                }
            }
        }
    }
}
