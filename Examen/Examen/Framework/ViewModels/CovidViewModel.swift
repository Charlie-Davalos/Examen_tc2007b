//
//  CovidViewModel.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import Foundation
import SwiftUI

/// ViewModel que conecta los datos de COVID con la vista
class CovidViewModel: ObservableObject {
    @Published var covidData: [CovidData] = []  // Datos que se actualizarán en la vista

    private let repository = CovidRepository()

    func loadCovidData() {
        let countries = ["USA"]  // Puedes agregar más países según sea necesario
        repository.getCovidData(for: countries) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.covidData = data  // Asignamos los datos obtenidos al arreglo
                case .failure(let error):
                    print("[ERROR] Error al cargar los datos: \(error.localizedDescription)")
                }
            }
        }
    }
}
