//
//  CovidView.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import SwiftUI

struct CovidView: View {
    @StateObject private var viewModel = CovidViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.covidData, id: \.country) { data in
                VStack(alignment: .leading) {
                    Text(data.country)
                        .font(.headline)
                    Text("Región: \(data.region.isEmpty ? "N/A" : data.region)")
                        .font(.subheadline)
                    
                    // Mostramos el primer caso del diccionario de fechas
                    if let firstCase = data.cases.first {
                        Text("Fecha: \(firstCase.key)")
                        Text("Total casos: \(firstCase.value.total)")
                        Text("Nuevos casos: \(firstCase.value.new)")
                    } else {
                        Text("Sin datos de casos disponibles")
                    }
                }
            }
            .navigationTitle("Covid Data")
            .onAppear {
                print("[INFO] Vista cargada, iniciando llamada a la API...")
                viewModel.loadCovidData()
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}
