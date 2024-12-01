//
//  CovidView.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import SwiftUI

struct CovidView: View {
    @ObservedObject var viewModel: CovidViewModel  // Observamos el ViewModel

    var body: some View {
        VStack {
            // Mostrar un mensaje si no hay datos aún
            if viewModel.covidData.isEmpty {
                Text("Cargando datos de COVID...")
                    .padding()
            } else {
                // Mostrar los datos de COVID en una lista
                List(viewModel.covidData, id: \.country) { covidData in
                    VStack(alignment: .leading) {
                        Text("País: \(covidData.country)")
                            .font(.headline)
                        
                        // Aquí recorremos el diccionario `cases` que tiene las fechas como claves
                        ForEach(covidData.cases.keys.sorted(), id: \.self) { date in
                            if let caseData = covidData.cases[date] {
                                VStack(alignment: .leading) {
                                    Text("Fecha: \(date)")
                                    Text("Total: \(caseData.total)")
                                    Text("Nuevo: \(caseData.new)")
                                }
                                .padding(.top, 5)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.loadCovidData()  // Llamamos al método para cargar los datos cuando la vista aparece
        }
        .navigationBarTitle("Datos de COVID", displayMode: .inline)
    }
}

struct CovidView_Previews: PreviewProvider {
    static var previews: some View {
        CovidView(viewModel: CovidViewModel())  // Pasamos el ViewModel
    }
}
