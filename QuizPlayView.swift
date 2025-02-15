//
//  SwiftUIView.swift
//  P4-IWEB
//
//  Created by labditmacvm on 24/11/24.
//

import SwiftUI

//------------------------------------------[QuizPlayView]---------------------------
struct QuizPlayView: View {
    let quiz: QuizItem // Recibe un objeto `QuizItem` que representa el quiz actual
    @Binding var correctAnswers: Set<Int> // Vincula un conjunto de identificadores de respuestas correctas que se comparte con otras vistas
    @State private var userAnswer: String = "" // Almacena la respuesta ingresada por el usuario
    @State private var showAlert = false // Controla la visibilidad de la alerta
    @State private var isCorrect = false // Indica si la respuesta ingresada es correcta
    @Environment(\.verticalSizeClass) private var verticalSizeClass // Obtiene la orientación de la pantalla
    
    var body: some View {
        if verticalSizeClass == .compact { // Comprueba si la pantalla está en horizontal
            horizontalView
        } else { // Si la pantalla está en vertical
            verticalView
        }
    }
    
    //------------------------------------------[Horizontal View]---------------------------
    private var horizontalView: some View {
        HStack {
            VStack {
                AsyncImage(url: quiz.attachment?.url) { image in // Carga una imagen desde la URL del adjunto del quiz
                    image.resizable().scaledToFit() // Ajusta la imagen para que se escale proporcionalmente y se ajuste al contenedor
                } placeholder: { // Marcador de posición mientras se carga la imagen
                    Color.gray // Muestra un fondo gris como marcador de posición
                }
                .clipShape(RoundedRectangle(cornerRadius: 12)) // Recorta la imagen en un rectángulo con bordes redondeados
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 3) // Aplica una sombra alrededor de la imagen
            }
            
            Spacer()
            
            VStack {
                Text(quiz.question) // Muestra la pregunta del quiz
                    .font(.title2) // Usa una fuente de tamaño grande
                    .bold()
                    .multilineTextAlignment(.center) // Centra el texto en múltiples líneas
                
                TextField("Enter your answer", text: $userAnswer) // Campo de texto para que el usuario ingrese su respuesta
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // Aplica un estilo redondeado al campo de texto
                    .padding()
                
                Button("Check Answer") { // Botón para verificar la respuesta ingresada
                    checkAnswer()
                }
                .buttonStyle(.borderedProminent)
                .alert(isPresented: $showAlert) { // Muestra una alerta cuando `showAlert` es true
                    Alert(
                        title: Text(isCorrect ? "Correct!" : "Wrong!"), // Título de la alerta según si la respuesta es correcta o no
                        message: Text(isCorrect ? "You got it right!" : "Try again."), // Mensaje de la alerta según el resultado
                        dismissButton: .default(Text("OK")) // Botón para cerrar la alerta
                    )
                }
            }
        }
        .padding()
    }
    
    //------------------------------------------[Vertical View]---------------------------
    private var verticalView: some View {
        VStack {
            Text(quiz.question) // Muestra la pregunta del quiz
                .font(.title2) // Usa una fuente de tamaño grande
                .bold()
                .multilineTextAlignment(.center) // Centra el texto en múltiples líneas
            
            AsyncImage(url: quiz.attachment?.url) { image in // Carga la imagen del adjunto del quiz
                image.resizable().scaledToFit() // Ajusta la imagen para que se escale proporcionalmente
            } placeholder: { // Marcador de posición mientras se carga la imagen
                Color.gray // Muestra un fondo gris como marcador de posición
            }
            .frame(height: 200) // Establece una altura fija para la imagen
            .clipShape(RoundedRectangle(cornerRadius: 12)) // Recorta la imagen en un rectángulo con bordes redondeados
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 3) // Aplica una sombra alrededor de la imagen
            
            TextField("Enter your answer", text: $userAnswer) // Campo de texto para que el usuario ingrese su respuesta
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Aplica un estilo redondeado al campo de texto
                .padding()
            
            Button("Check Answer") { // Botón para verificar la respuesta ingresada
                checkAnswer()
            }
            .buttonStyle(.borderedProminent)
            .alert(isPresented: $showAlert) { // Muestra una alerta cuando `showAlert` es true
                Alert(
                    title: Text(isCorrect ? "Correct!" : "Wrong!"), // Título de la alerta según si la respuesta es correcta o no
                    message: Text(isCorrect ? "You got it right!" : "Try again."), // Mensaje de la alerta según el resultado
                    dismissButton: .default(Text("OK")) // Botón para cerrar la alerta
                )
            }
        }
        .padding()
    }
    
    //------------------------------------------[Functions]---------------------------
    private func checkAnswer() {
        isCorrect = userAnswer.lowercased() == quiz.answer.lowercased() // Compara la respuesta del usuario con la respuesta correcta ignorando mayúsculas
        if isCorrect {
            correctAnswers.insert(quiz.id) // Agrega el id del quiz al conjunto de respuestas correctas
        }
        showAlert = true // Muestra la alerta
    }
}
