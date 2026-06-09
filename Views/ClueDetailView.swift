import SwiftUI

// Detail screen that shows one clue and lets the user take a photo.
struct ClueDetailView: View {
    
    let item: ScavengerItem
    var session: HuntSession
    
    // Controls the camera sheet.
    @State private var showCamera = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "F8FBFF"), Color(hex: "E8F7F4")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 22) {
                    // Hero image banner for this item
                    ZStack(alignment: .bottomLeading) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 220)
                            .clipped()

                        if item.isFound {
                            Label("Found!", systemImage: "checkmark.seal.fill")
                                .font(.subheadline.bold())
                                .foregroundStyle(.white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Color(hex: "0E9F8F"))
                                .clipShape(Capsule())
                                .padding(14)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .shadow(color: .black.opacity(0.1), radius: 12, y: 6)

                    VStack(spacing: 8) {
                        Text(item.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: "1F2937"))
                        
                        Text(item.businessName)
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Clue", systemImage: "lightbulb.fill")
                            .font(.headline)
                            .foregroundStyle(Color(hex: "0E9F8F"))
                        
                        Text(item.clue)
                            .font(.body)
                            .foregroundStyle(Color(hex: "374151"))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white.opacity(0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    if item.isFound, let photo = item.photo {
                        VStack(alignment: .leading, spacing: 10) {
                            Label("Item Found", systemImage: "checkmark.circle.fill")
                                .font(.headline)
                                .foregroundStyle(Color(hex: "0E9F8F"))
                            
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                        }
                        .padding()
                        .background(.white.opacity(0.95))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        Button(action: { showCamera = true }) {
                            Label("Take Photo and Mark Found", systemImage: "camera.fill")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "0E9F8F"))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Item Detail")
        .sheet(isPresented: $showCamera) {
            // Opens the camera view and saves the photo.
            CameraView { photo in
                session.markAsFound(id: item.id, photo: photo)
                showCamera = false
            }
        }
    }
}
