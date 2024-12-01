//
//  CovidView.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import SwiftUI

/// Vista principal que muestra los datos de COVID
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
                print("[INFO] Vista cargada, llamando a ViewModel...")
                viewModel.loadCovidData()
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct CovidView_Previews: PreviewProvider {
    static var previews: some View {
        CovidView()
    }
}
