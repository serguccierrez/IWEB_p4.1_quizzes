//
//  ContentView.swift
//  P4-IWEB
//
//  Created by labditmacvm on 13/11/24.
//
import SwiftUI

//------------------------------------------[HomeScreenView]---------------------------
struct HomeScreenView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass // Obtiene información sobre la orientación de la pantalla
    @State private var correctAnswers: Set<Int> = [] // Variable de estado para controlar las respuestas correctas
    
    var body: some View {
        if verticalSizeClass == .compact { // Comprueba si el dispositivo está en orientación horizontal
            horizontalView
        } else { // Si está en vertical
            verticalView
        }
    }
    
    //------------------------------------------[Horizontal View]---------------------------
    private var horizontalView: some View {
        NavigationStack { // Envuelve la vista en un contenedor de navegación
            HStack {
                VStack {
                    Text("Quizzes") // Título principal
                        .font(.largeTitle) // Establece una fuente grande
                        .bold() // Hace el texto en negrita
                        .padding(.horizontal, 130) // Agrega espacio horizontal
                        .padding(.top, 50) // Agrega espacio superior
                    
                    Text("¡Demuestra lo que sabes!") //  Titulo secundario
                        .font(.title3) // Fuente de tamaño mediano
                        .foregroundColor(.gray) // Cambia el color del texto a gris
                        .padding(.horizontal, 90)
                    
                    Spacer() // Agrega un espacio para separar los elementos
                    
                    NavigationLink(destination: QuizListView(correctAnswers: $correctAnswers)) { // Crea un enlace de navegación que lleva a `QuizListView`
                        OptionButton(title: "Jugar", SystemIconName: "play")
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text("Desarrollado por Sergio, Álvaro y Patricia") // Texto de pie de página
                        .font(.footnote) // Fuente pequeña
                        .foregroundColor(.gray)
                        .padding(.horizontal, 80)
                }
                .padding()
                
                Spacer()
                
                Image(systemName: "questionmark") // Muestra un icono de signo de interrogación
                    .resizable() // Hace que la imagen pueda cambiar de tamaño
                    .padding(.trailing, 70) // Agrega espacio a la derecha
                    .frame(width: 300, height: 300) // Define el tamaño de la imagen
            }
        }
    }
    
    //------------------------------------------[Vertical View]---------------------------
    private var verticalView: some View {
        VStack {
            NavigationStack {
                Text("Quizzes") // Título principal
                    .font(.largeTitle) // Fuente grande
                    .bold() // Texto en negrita
                    .frame(maxWidth: .infinity, alignment: .center) // Centra el texto horizontalmente
                    .padding(.top, 30)
                
                Text("¡Demuestra lo que sabes!") // Titulo secundario
                    .font(.title3)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Image(systemName: "questionmark") // Muestra un icono de signo de interrogación
                    .resizable() // Hace que la imagen pueda cambiar de tamaño
                    .frame(width: 200, height: 300) // Define el tamaño de la imagen
                    .padding(.top, 40)
                
                Spacer()
                
                NavigationLink(destination: QuizListView(correctAnswers: $correctAnswers)) {
                    OptionButton(title: "Jugar", SystemIconName: "play")
                }
                
                Spacer()
                
                Text("Desarrollado por Sergio, Álvaro y Patricia")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

//------------------------------------------[OptionButton]---------------------------
struct OptionButton: View { // Define una estructura que representa un botón personalizado
    var title: String // Título del botón
    var SystemIconName: String // Nombre del icono del sistema que se mostrará en el botón
    
    var body: some View { // Define el contenido visual del botón
        HStack {
            Spacer()
            
            Image(systemName: SystemIconName) // Muestra el icono del sistema
                .resizable() // Permite redimensionar la imagen
                .frame(width: 30, height: 30) // Define el tamaño del icono
            
            Text(title) // Muestra el texto del botón
                .font(.headline) // Fuente destacada para el texto
            
            Spacer()
        }
        .padding(10) // Agrega espacio interno al botón
        .background( // Agrega un fondo al botón
            RoundedRectangle(cornerRadius: 5) // Fondo con bordes redondeados
                .stroke(Color.blue) // Define un borde azul
        )
        .padding(.horizontal, 40) // Agrega espacio horizontal alrededor del botón
    }
}

//------------------------------------------[Preview]---------------------------
#Preview {
    HomeScreenView() 
}
