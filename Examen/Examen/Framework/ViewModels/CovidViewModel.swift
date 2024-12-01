//
//  CovidViewModel.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import Foundation

class CovidViewModel: ObservableObject {
    @Published var covidData: [CovidData] = []
    
    private let repository = CovidRepository()

    func loadCovidData() {
        let countries = ["Mexico", "USA", "Canada", "India", "Brazil", "Germany", "Croatia", "Argentina", "Russia", "France", "Spain", "China", "Japan", "Nicaragua", "Italy", "Colombia"]  // Aquí puedes agregar más países
        repository.getCovidData(for: countries) { [weak self] result in
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
