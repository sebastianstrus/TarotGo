import SwiftUI
import MapKit

struct VibeCheckView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var position: MapCameraPosition = .automatic
    @State private var selectedVibe: VibeCheckService.CityVibe?
    @State private var showCardDetail = false
    
    private let vibes = VibeCheckService.getTodayVibes()
    private let todayDate = VibeCheckService.getTodayDateString()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                AppTheme.backgroundGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    headerView
                    
                    // Map
                    mapView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.white.opacity(0.7))
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showCardDetail) {
                if let vibe = selectedVibe {
                    NavigationStack {
                        CardDetailView(card: vibe.card)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Done") {
                                        showCardDetail = false
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("🌍 Global Vibe Check")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
            
            Text(todayDate)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
            
            Text("Tap any city to see its vibe")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.3))
    }
    
    private var mapView: some View {
        Map(position: $position, interactionModes: [.pan, .zoom]) {
            ForEach(vibes) { vibe in
                Annotation(vibe.cityName, coordinate: CLLocationCoordinate2D(latitude: vibe.latitude, longitude: vibe.longitude)) {
                    CityVibeMarker(vibe: vibe, isSelected: selectedVibe?.id == vibe.id)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3)) {
                                selectedVibe = vibe
                            }
                            
                            // Center map on selected city
                            withAnimation {
                                position = .region(MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude: vibe.latitude, longitude: vibe.longitude),
                                    span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
                                ))
                            }
                        }
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic, pointsOfInterest: .including([.publicTransport])))
        .overlay(alignment: .bottom) {
            if let vibe = selectedVibe {
                vibeInfoCard(vibe: vibe)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
    
    private func vibeInfoCard(vibe: VibeCheckService.CityVibe) -> some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(vibe.cityName)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(vibe.countryName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                        .font(.title3)
                }
            }
            
            Divider()
            
            HStack(spacing: 16) {
                // Card image
                if let uiImage = UIImage(named: vibe.card.imageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 90)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AppTheme.darkNavy)
                        .frame(width: 60, height: 90)
                        .overlay {
                            Text("?")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(vibe.card.name)
                        .font(.headline)
                    
                    Text("\(vibe.percentage)% of readings today")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Button(action: {
                        showCardDetail = true
                    }) {
                        Text("View Card Details")
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                    }
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .shadow(radius: 10)
        }
        .padding()
    }
}

struct CityVibeMarker: View {
    let vibe: VibeCheckService.CityVibe
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            // Pulse effect
            if isSelected {
                Circle()
                    .fill(AppTheme.gold.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .scaleEffect(isSelected ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isSelected)
            }
            
            // Main marker
            VStack(spacing: 2) {
                ZStack {
                    Circle()
                        .fill(AppTheme.goldGradient)
                        .frame(width: isSelected ? 32 : 28, height: isSelected ? 32 : 28)
                        .shadow(color: AppTheme.gold.opacity(0.5), radius: isSelected ? 6 : 3)
                    
                    if let uiImage = UIImage(named: vibe.card.imageName) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: isSelected ? 28 : 24, height: isSelected ? 28 : 24)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(AppTheme.gold, lineWidth: 1)
                            )
                    } else {
                        Text("?")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                }
                
                Text(vibe.cityName)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background {
                        Capsule()
                            .fill(.black.opacity(0.7))
                    }
            }
        }
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
    }
}

#Preview {
    VibeCheckView()
}
