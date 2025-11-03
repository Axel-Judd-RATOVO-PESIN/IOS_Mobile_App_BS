import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State var profileViewModel = ProfileViewModel()
    @State private var isEditing = false

    // Photo Picker
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Image de profil
            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.blue, lineWidth: 2))
            } else {
                Image(systemName: profileViewModel.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundStyle(.blue)
                    .padding()
                    .background(Circle().fill(.blue.opacity(0.1)))
                    .overlay(Circle().stroke(.blue.opacity(0.3), lineWidth: 2))
            }
            
            // Bouton Photo Picker visible seulement en mode édition
            if isEditing {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Label("Choisir une photo", systemImage: "photo")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                .onChange(of: selectedItem) { oldItem, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            selectedImage = uiImage
                        }
                    }
                }
            }
            
            // Nom et prénom
            if isEditing {
                TextField("Prénom", text: $profileViewModel.prenom)
                    .textFieldStyle(.roundedBorder)
                TextField("Nom", text: $profileViewModel.nom)
                    .textFieldStyle(.roundedBorder)
            } else {
                Text("\(profileViewModel.prenom) \(profileViewModel.nom)")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            // Description
            if isEditing {
                TextField("Description", text: $profileViewModel.desc, axis: .vertical)
                    .lineLimit(3...6)
                    .textFieldStyle(.roundedBorder)
            } else {
                Text(profileViewModel.desc)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            // Bouton Modifier / Terminer
            Button(isEditing ? "Terminer" : "Modifier") {
                withAnimation {
                    isEditing.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(isEditing ? .green : .blue)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profil")
    }
}

#Preview {
    ProfileView()
}
