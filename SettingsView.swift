//
//  SettingView.swift
//  P4-IWEB
//
//  Created by labditmacvm on 24/11/24.
//

import SwiftUI

//------------------------------------------[SettingsView]---------------------------
struct SettingsView: View {
    @Binding var correctAnswers: Set<Int> // Referencia vinculada al conjunto de respuestas correctas que se comparte con otras vistas

    var body: some View {
        VStack {
            //------------------------------------------[Header]---------------------------
            Text("Settings") // Título de la pantalla
                .font(.largeTitle) // Usa una fuente de tamaño grande
                .bold()

            //------------------------------------------[Reset Button]---------------------------
            Button(action: { // Botón con una acción asociada
                correctAnswers.removeAll() // Limpia el conjunto de respuestas correctas
            }) {
                Text("Reset Correct Answers")
                    .foregroundColor(.white) // Cambia el color del texto a blanco
                    .padding()
                    .frame(maxWidth: .infinity) // Hace que el botón ocupe todo el ancho disponible
                    .background(Color.red) // Define un fondo rojo para el botón
                    .cornerRadius(10) // Aplica bordes redondeados al botón
            }
            .padding()

            Spacer()
        }
        .padding()
        .navigationTitle("Settings") 
    }
}
