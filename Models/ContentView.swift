import SwiftUI

// Main screen for the Scavenger Hunt app.
struct ContentView: View {
    
    @State private var session = HuntSession()
    
    var body: some View {
        NavigationStack {
            ZStack {
                appBackground
                
                ScrollView {
                    VStack(spacing: 22) {
                        heroCard
                        progressCard
                        startButtons
                        huntList
                    }
                    .padding()
                }
            }
            .navigationTitle("Local Hunt")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: ResultsView(session: session)) {
                        Label("Results", systemImage: "gift.fill")
                    }
                }
            }
        }
    }
    
    // Soft colorful background for the new design.
    private var appBackground: some View {
        LinearGradient(
            colors: [Color(hex: "F8FBFF"), Color(hex: "E8F7F4"), Color(hex: "FFF4E6")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    // Welcome card shown when the app launches.
    private var heroCard: some View {
        VStack(spacing: 12) {
            Image("hero_splash")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 18))

            Text("Scavenger Hunt")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color(hex: "1F2937"))
            
            Text("Created by ")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color(hex: "0E9F8F"))
            
            Text("Visit local businesses, follow clues, take photos, and unlock discount rewards.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: .black.opacity(0.08), radius: 14, y: 8)
    }
    
    // Shows current hunt progress.
    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Progress")
                    .font(.headline)
                Spacer()
                Text("\(session.foundCount) / \(session.items.count)")
                    .font(.headline)
                    .foregroundStyle(Color(hex: "0E9F8F"))
            }
            
            ProgressView(value: Double(session.foundCount), total: Double(session.items.count))
                .tint(Color(hex: "0E9F8F"))
            
            Text("Find 5 or more items to earn a reward.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    // Demo buttons help show reward logic during marking.
    private var startButtons: some View {
        HStack(spacing: 12) {
            Button("Demo 5") { session.simulateFound(5) }
                .buttonStyle(HuntButtonStyle())
            Button("Demo 7") { session.simulateFound(7) }
                .buttonStyle(HuntButtonStyle())
            Button("Reset") { session.resetHunt() }
                .buttonStyle(HuntButtonStyle(isSecondary: true))
        }
    }
    
    // List of all 10 hunt items.
    private var huntList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Hidden Items")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(hex: "1F2937"))
            
            ForEach(session.items) { item in
                NavigationLink(destination: ClueDetailView(item: item, session: session)) {
                    ItemRow(item: item)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// Custom row design for each scavenger hunt item.
private struct ItemRow: View {
    let item: ScavengerItem

    var body: some View {
        HStack(spacing: 14) {
            ZStack(alignment: .bottomTrailing) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 52, height: 52)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                if item.isFound {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color(hex: "0E9F8F"))
                        .background(Color.white.clipShape(Circle()))
                        .offset(x: 4, y: 4)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundStyle(Color(hex: "1F2937"))
                Text(item.businessName)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.white.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
    }
}

// Simple reusable button style for the home screen.
private struct HuntButtonStyle: ButtonStyle {
    var isSecondary = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .fontWeight(.bold)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(isSecondary ? Color.white : Color(hex: "0E9F8F"))
            .foregroundStyle(isSecondary ? Color(hex: "0E9F8F") : .white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color(hex: "0E9F8F"), lineWidth: isSecondary ? 1 : 0)
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
    }
}

// Allows simple hex colors in SwiftUI.
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
