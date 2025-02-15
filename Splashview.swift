//
//  Splashview.swift
//  P4-IWEB
//
//  Created by labditmacvm on 2/12/24.
//
import SwiftUI

//------------------------------------------[Splashview]---------------------------
struct Splashview: View {
    @State private var SlashNotActive = false // Declara una variable de estado para controlar si la vista de inicio debe mostrarse o no
    @Environment(\.verticalSizeClass) private var verticalSizeClass // Obtiene información sobre la orientación de la pantalla
    
    var body: some View {
        if SlashNotActive { // Comprueba si `SlashNotActive` es true
            HomeScreenView()
        } else { // Si no, muestra la pantalla de splash
            if verticalSizeClass == .compact { // Comprueba si el dispositivo está en orientación horizontal
                horizontalSplashView
            } else { // Si el dispositivo está en orientación vertical
                verticalSplashView
            }
        }
    }
    
    //------------------------------------------[Horizontal Splash View]---------------------------
    private var horizontalSplashView: some View {
        VStack {
            Image("Icono") // Muestra la imagen llamada "Icono" que está en los assets
                .padding(.top, 25)
            Text("Quiz App")
                .font(.system(size: 30)) // Establece una fuente personalizada con tamaño 30
            Spacer()
            Text("IWEB-2024")
                .foregroundColor(.gray)
        }
        .onAppear { // Define una acción que ocurre cuando esta vista aparece
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Ejecuta un bloque de código después de 2 segundos
                withAnimation { // Aplica una animación a los cambios de estado
                    self.SlashNotActive = true // Cambia `SlashNotActive` a true para mostrar la vista de inicio
                }
            }
        }
    }
    
    //------------------------------------------[Vertical Splash View]---------------------------
    private var verticalSplashView: some View {
        VStack {
            Image("Icono") // Muestra la imagen llamada "Icono" que está en los assets
                .padding(.top, 225)
            Text("Quiz App")
                .font(.system(size: 30)) // Establece una fuente personalizada con tamaño 30
            Spacer()
            Text("IWEB-2024")
                .foregroundColor(.gray)
        }
        .onAppear { // Define una acción que ocurre cuando esta vista aparece
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Ejecuta un bloque de código después de 2 segundos
                withAnimation { // Aplica una animación a los cambios de estado
                    self.SlashNotActive = true // Cambia `SlashNotActive` a true para mostrar la vista de inicio
                }
            }
        }
    }
}

//------------------------------------------[Preview]---------------------------
#Preview {
    Splashview()
}
