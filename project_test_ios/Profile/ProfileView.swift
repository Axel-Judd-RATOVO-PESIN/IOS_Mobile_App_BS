import SwiftUI
import PhotosUI
import DesignSystem
// --- J'ajoute un ViewModel d'exemple pour que le code fonctionne ---
// (Tu as déjà ton ProfileViewModel, c'est juste pour le Preview)

struct ProfileView: View {
    @State var profileViewModel = ProfileViewModel()
    @State private var isEditing = false

    // Photo Picker
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
     
    var body: some View {
        // 1. Remplacer VStack par Form
        // Un Form est conçu pour les réglages et les profils.
        // Il doit être dans une NavigationStack pour avoir le titre.
        Form {
            
            // --- 2. Section de l'image (en-tête) ---
            // On la met au-dessus des sections, centrée.
            HStack {
                Spacer() // Pousse le VStack au centre
                VStack(spacing: 16) {
                    
                    // J'ai extrait la logique de l'image dans une vue séparée (voir plus bas)
                    // C'est plus propre !
                    
                    if isEditing {
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images
                        ) {
                            // On utilise un style plus simple pour le bouton
                            Label("Changer de photo", systemImage: "camera")
                                .font(.caption) // Plus petit, plus discret
                        }
                    }else {
                        // Affiche l'image par défaut de ton ViewModel
                        // C'est ici qu'on utilise Image(profileViewModel.image)
                        Image(profileViewModel.image)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.blue)
                            .padding(30)
                            .background(Circle().fill(.blue.opacity(0.1)))
                    }
                }
                .padding(.vertical, 10)
                Spacer() // Pousse le VStack au centre
            }
            // Ceci enlève le fond gris de la cellule du Form
            .listRowBackground(Color.clear)
            
            
            // --- 3. Regrouper les infos dans des Sections ---
            Section(header: Text("Informations Personnelles")) {
                // Un seul "if" pour tout le bloc !
                if isEditing {
                    TextField("Prénom", text: $profileViewModel.prenom)
                    TextField("Nom", text: $profileViewModel.nom)
                } else {
                    // En mode "vue", on utilise un style "Réglages" (clé/valeur)
                    HStack {
                        Text("Prénom")
                            .foregroundColor(.secondary) // Couleur discrète
                        Spacer()
                        Text(profileViewModel.prenom)
                    }
                    HStack {
                        Text("Nom")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(profileViewModel.nom)
                    }
                }
            }
            
            Section(header: Text("Description")) {
                if isEditing {
                    TextField("Description", text: $profileViewModel.desc, axis: .vertical)
                        .lineLimit(4...8) // Permet à l'utilisateur de voir plus de lignes
                } else {
                    // On garde le texte simple, mais on ajoute un message
                    // si la description est vide
                    Text(profileViewModel.desc.isEmpty ? "Pas de description" : profileViewModel.desc)
                        .foregroundColor(profileViewModel.desc.isEmpty ? .secondary : .primary)
                }
            }

        }
        // Le titre est maintenant géré par la NavigationStack
        .navigationTitle("Profil")
        
        // --- 4. Mettre le bouton dans la barre de navigation ---
        // C'est la convention sur iOS (comme "OK" ou "Annuler")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Terminer" : "Modifier") {
                    withAnimation {
                        isEditing.toggle()
                        
                        // C'est ici que tu sauvegarderais les données
                        if !isEditing {
                            // ex: profileViewModel.saveChanges()
                        }
                    }
                }
                .tint(isEditing ? .green : .blue)
            }
        }
        
        // --- 5. Le .onChange pour le PhotoPicker ---
        // Il peut rester ici, il surveille 'selectedItem'
        .onChange(of: selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    
                    // On met à jour l'image affichée
                    await MainActor.run {
                        selectedImage = uiImage
                        // Tu voudrais aussi sûrement sauvegarder cette image
                        // dans ton viewModel
                    }
                }
            }
        }
    }
}

// --- 6. (BONUS) Vue séparée pour l'image de profil ---
// C'est une bonne pratique. Ça garde ton 'body' principal propre.
struct ProfileImageView: View {
    @Binding var selectedImage: UIImage?
    var defaultImageName: String
    
    var body: some View {
        Group {
            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    // .scaledToFill est souvent mieux pour une photo de profil
                    .scaledToFill()
            } else {
                // Utilise Image(systemName:) si c'est une icône SFSymbol
                Image(systemName: defaultImageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.blue)
                    .padding(30) // Plus d'espace intérieur
                    .background(Circle().fill(.blue.opacity(0.1)))
            }
        }
        .frame(width: 120, height: 120)
        .clipShape(Circle())
        .overlay(Circle().stroke(.blue.opacity(0.3), lineWidth: 2))
    }
}


#Preview {
    // 7. Important : Pour voir le .navigationTitle et .toolbar,
    // le Preview doit être dans une NavigationStack !
    NavigationStack {
        ProfileView()
    }
}
