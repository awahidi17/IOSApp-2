import SwiftUI

// Results screen that shows progress, reward, and online submission.
struct ResultsView: View {
    
    var session: HuntSession
    
    // Controls the submit confirmation alert.
    @State private var showSubmitAlert = false
    @State private var submitted = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "F8FBFF"), Color(hex: "E8F7F4"), Color(hex: "FFF4E6")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    resultsHeader
                    rewardCard
                    itemSummary
                    submitArea
                }
                .padding()
            }
        }
        .navigationTitle("Results")
        .alert("Submit Results?", isPresented: $showSubmitAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Submit") {
                submitted = true
            }
        } message: {
            Text("You found \(session.foundCount) out of \(session.items.count) items. Ready to submit online?")
        }
    }
    
    // Shows the number of found items.
    private var resultsHeader: some View {
        VStack(spacing: 12) {
            Image(systemName: "trophy.circle.fill")
                .font(.system(size: 72))
                .foregroundStyle(Color(hex: "F59E0B"))
            
            Text("Your Hunt Results")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color(hex: "1F2937"))
            
            Text("\(session.foundCount) out of \(session.items.count) items found")
                .font(.title3)
                .foregroundStyle(.secondary)
            
            ProgressView(value: Double(session.foundCount), total: Double(session.items.count))
                .tint(Color(hex: "0E9F8F"))
        }
        .padding()
        .background(.white.opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    // Shows the reward earned by the user.
    private var rewardCard: some View {
        VStack(spacing: 12) {
            if let code = session.discountCode {
                Text(session.foundCount == 10 ? "Grand Prize Entry Unlocked" : "Discount Unlocked")
                    .font(.headline)
                    .foregroundStyle(Color(hex: "0E9F8F"))
                
                Text(code)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "1F2937"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "E8F7F4"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Text(session.foundCount == 10 ? "20% off plus entry into the $5000 draw." : session.foundCount >= 7 ? "20% off reward earned." : "10% off reward earned.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            } else {
                Text("No Reward Yet")
                    .font(.headline)
                    .foregroundStyle(Color(hex: "F59E0B"))
                Text("Find at least 5 items to earn a discount code.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white.opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    // Lists every item and its found status.
    private var itemSummary: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Item Summary")
                .font(.headline)
                .foregroundStyle(Color(hex: "1F2937"))

            ForEach(session.items) { item in
                HStack(spacing: 12) {
                    // Item image thumbnail
                    ZStack(alignment: .bottomTrailing) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 46, height: 46)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .opacity(item.isFound ? 1 : 0.35)

                        if item.isFound {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(Color(hex: "0E9F8F"))
                                .background(Color.white.clipShape(Circle()))
                                .offset(x: 4, y: 4)
                        }
                    }

                    Text(item.name)
                        .foregroundStyle(item.isFound ? Color(hex: "1F2937") : .secondary)
                        .font(.subheadline)

                    Spacer()

                    Text(item.isFound ? "Found ✓" : "Missing")
                        .font(.caption)
                        .fontWeight(item.isFound ? .semibold : .regular)
                        .foregroundStyle(item.isFound ? Color(hex: "0E9F8F") : .secondary)
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .background(.white.opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    // Allows the user to submit results online.
    private var submitArea: some View {
        VStack(spacing: 10) {
            if submitted {
                Label("Results Submitted", systemImage: "checkmark.seal.fill")
                    .font(.headline)
                    .foregroundStyle(Color(hex: "0E9F8F"))
                Text("The Chamber of Commerce will review the results.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Button(action: { showSubmitAlert = true }) {
                    Label("Submit Results Online", systemImage: "paperplane.fill")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(session.foundCount > 0 ? Color(hex: "0E9F8F") : Color.gray)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .disabled(session.foundCount == 0)
            }
        }
        .padding(.bottom)
    }
}
