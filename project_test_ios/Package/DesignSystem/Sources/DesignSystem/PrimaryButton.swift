//
//  PrimaryButton.swift
//  DesignSystem
//
//  Created by RATOVO PESIN Axel Judd on 04/11/2025.
//

import SwiftUI

public struct PrimaryButton: View {
    
    // --- Les paramètres flexibles (idem) ---
    let title: String
    var icon: Image? = nil
    var isLoading: Bool = false
    let action: () -> Void
    
    // 2. Rendre L'INITIALISEUR public
    // Sans cela, vous ne pouvez pas appeler PrimaryButton(...) depuis l'extérieur
    /*public init(title: String, icon: Image? = nil, isLoading: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.isLoading = isLoading
        self.action = action
    }
    */
    
    public init(title: String, icon: Image? = nil, isLoading: Bool, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.isLoading = isLoading
        self.action = action
    }
    
    // --- Le corps de la vue ---
    
    public var body: some View {
        Button(action: action) {
            
            // --- C'est ici qu'on recrée le style ---
            
            // 1. Le contenu (Label)
            HStack(spacing: 10) {
                if isLoading {
                    ProgressView()
                        .tint(.white) // Assure que le spinner est blanc
                } else {
                    if let icon = icon {
                        icon
                            .font(.title) // S'assure que l'icône a la bonne taille
                    }
                    Text(title)
                }
            }
            // 2. Les modificateurs de style (qui étaient dans le ButtonStyle)
            .font(.title)
            .padding(16)
            .frame(maxWidth: .infinity) // Prend toute la largeur
            .background(.blue, in: RoundedRectangle(cornerRadius: 16))
            .foregroundColor(.white)
            
        }
        // On désactive le bouton pendant le chargement
        .disabled(isLoading)
    }
}
