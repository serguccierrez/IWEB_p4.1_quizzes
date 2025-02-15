//
//  QuizzesView.swift
//  P4-IWEB
//
//  Created by labditmacvm on 24/11/24.
//
import SwiftUI

//------------------------------------------[QuizListView]---------------------------
struct QuizListView: View {
    
    @State private var model = QuizzesModel() // Declara una variable de estado que contiene el modelo de los quizzes
    @Binding var correctAnswers: Set<Int> // Vincula un conjunto de identificadores de respuestas correctas que se comparte con otras vistas
    @State private var favoriteQuizzes: Set<Int> = [] // Variable de estado para almacenar los quizzes marcados como favoritos
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                //------------------------------------------[Header]---------------------------
                HStack {
                    Text("Completados: \(correctAnswers.count) de \(model.quizzes.count)") // Muestra la cantidad de quizzes completados del total
                        .font(.headline) // Aplica una fuente destacada
                        .foregroundColor(.gray)
                        .padding(.leading) // Agrega espacio al lado izquierdo
                    
                    Spacer()
                }
                .padding(.bottom, 5)
                
                //------------------------------------------[Quiz List]---------------------------
                List(model.quizzes.filter { $0.question.count <= 100 }, id: \.id) { quiz in // Crea una lista filtrando los quizzes con preguntas de máximo 100 caracteres
                    
                    NavigationLink(destination: QuizPlayView(quiz: quiz, correctAnswers: $correctAnswers)) { // Navega a la vista de juego del quiz al seleccionarlo
                        
                        HStack(spacing: 10) { // Organiza los elementos horizontalmente con un espaciado de 10 puntos
                            
                            AsyncImage(url: quiz.attachment?.url) { image in // Carga una imagen desde una URL
                                image.resizable().scaledToFill() // Ajusta la imagen para llenar su espacio
                            } placeholder: { // Define un marcador de posición mientras se carga la imagen
                                Circle().fill(Color.gray) // Dibuja un círculo gris como marcador de posición
                            }
                            .frame(width: 60, height: 60) // Define el tamaño del círculo o la imagen
                            .clipShape(Circle()) // Recorta la imagen en forma de círculo
                            .shadow(radius: 8)
                            
                            VStack(alignment: .leading) {
                                Text(quiz.question) // Muestra la pregunta del quiz
                                    .font(.headline)
                                    .lineLimit(2) // Limita el texto de la pregunta a dos líneas
                                
                                if let author = quiz.author { // Comprueba si el quiz tiene un autor
                                    HStack {
                                        AsyncImage(url: author.photo?.url) { image in // Carga la imagen del autor
                                            image.resizable() // Permite redimensionar la imagen
                                        } placeholder: { // Define un marcador de posición para la imagen del autor
                                            Circle().fill(Color.gray) // Muestra un círculo gris
                                        }
                                        .frame(width: 15, height: 15) // Define el tamaño del marcador de posición o imagen
                                        .clipShape(Circle()) // Recorta la imagen en forma de círculo
                                        
                                        Text(author.profileName ?? author.username ?? "Unknown") // Muestra el nombre del autor o "Unknown" si no está disponible
                                            .font(.caption)
                                    }
                                }
                            }
                            Spacer()
                            
                            Button(action: { // Crea un botón para marcar o desmarcar como favorito
                                toggleFavorite(for: quiz) // Llama a la función para alternar el estado de favorito
                            }) {
                                Image(systemName: favoriteQuizzes.contains(quiz.id) ? "star.fill" : "star") // Muestra un icono de estrella rellena si es favorito o vacío si no lo es
                                    .foregroundColor(.yellow) // Cambia el color del icono a amarillo
                            }
                            .buttonStyle(.plain) // Elimina los estilos predeterminados del botón
                        }
                    }
                    .padding(.vertical, 10)
                }
                .listStyle(PlainListStyle()) // Usa un estilo de lista simple sin decoraciones adicionales
            }
            .navigationTitle("Quizzes") // Establece el título de la barra de navegación
            .toolbar { // Agrega elementos a la barra de herramientas
                ToolbarItem(placement: .navigationBarTrailing) { // Ubica un elemento en la esquina superior derecha
                    Text("Score: \(correctAnswers.count)")
                }
                ToolbarItem(placement: .navigationBarTrailing) { // Ubica otro elemento en la esquina superior derecha
                    NavigationLink(destination: SettingsView(correctAnswers: $correctAnswers)) { // Navega a la vista de configuración
                        Image(systemName: "gear") // Muestra un icono de engranaje
                    }
                }
            }
            .onAppear { // Define una acción que ocurre cuando la vista aparece
                model.load() // Carga los datos del modelo de quizzes
                favoriteQuizzes = Set(model.quizzes.filter { $0.favourite }.map { $0.id }) // Inicializa los favoritos basándose en los datos del modelo
            }
        }
    }
    
    //------------------------------------------[Functions]---------------------------
    private func toggleFavorite(for quiz: QuizItem) { // Función para alternar el estado de favorito de un quiz
        if favoriteQuizzes.contains(quiz.id) { // Comprueba si el quiz ya está en favoritos
            favoriteQuizzes.remove(quiz.id) // Lo elimina de los favoritos si ya está
        } else { // Si no está en favoritos
            favoriteQuizzes.insert(quiz.id) // Lo agrega a la lista de favoritos
        }
    }
}


