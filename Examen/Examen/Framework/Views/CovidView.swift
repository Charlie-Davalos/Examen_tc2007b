//
//  CovidView.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import SwiftUI

struct CovidView: View {
    @ObservedObject var viewModel: CovidViewModel  // ViewModel general para cargar los datos
    @State private var selectedCountry: String?  // Estado para guardar el país seleccionado

    var body: some View {
        NavigationView {
            VStack {
                // Mostrar un mensaje si no hay datos aún
                if viewModel.covidData.isEmpty {
                    Text("Cargando datos de COVID...")
                        .padding()
                } else {
                    // Mostrar la lista de países ordenada alfabéticamente
                    List(viewModel.covidData.sorted(by: { $0.country < $1.country }), id: \.country) { covidData in
                        NavigationLink(
                            destination: CountryDetailsView(country: covidData.country, cases: covidData.cases), // Pasamos el país y sus casos
                            tag: covidData.country,
                            selection: $selectedCountry) {
                                Text(covidData.country)  // Mostrar el nombre del país
                                    .padding()
                            }
                    }
                }
            }
            .onAppear {
                viewModel.loadCovidData()  // Cargar los datos cuando la vista aparece
            }
            .navigationBarTitle("Seleccionar país", displayMode: .inline)
        }
    }
}

// Vista para mostrar los detalles de un país específico
struct CountryDetailsView: View {
    var country: String
    var cases: [String: CaseData]  // Diccionario de fechas y casos

    var body: some View {
        VStack {
            Text("Datos de COVID para \(country)")
                .font(.title)
                .padding()

            // Mostrar los casos en una lista ordenada por fecha
            List(cases.sorted(by: { $0.key < $1.key }), id: \.key) { date, caseData in
                VStack(alignment: .leading) {
                    Text("Fecha: \(date)")
                        .font(.headline)
                    Text("Total: \(caseData.total)")
                    Text("Nuevo: \(caseData.new)")
                }
                .padding(.top, 5)
            }
        }
        .navigationBarTitle(country, displayMode: .inline)  // Mostrar el nombre del país en la barra de navegación
    }
}

struct CovidView_Previews: PreviewProvider {
    static var previews: some View {
        CovidView(viewModel: CovidViewModel())  // Pasamos el ViewModel para la vista
    }
}
