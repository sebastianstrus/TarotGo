import SwiftUI
import MapKit

struct VibeCheckView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var locationService = LocationService.shared
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
            .onAppear {
                // Request location permission when view appears
                if locationService.authorizationStatus == .notDetermined {
                    locationService.requestLocationPermission()
                }
                
                // Center map on user location if available
                if let userLocation = locationService.userLocation {
                    position = .region(MKCoordinateRegion(
                        center: userLocation,
                        span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
                    ))
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("🌍 Global Vibe Check")
                .font(AppTheme.serifFont(size: 28, weight: .light))
                .multilineTextAlignment(.center)
                .foregroundStyle(AppTheme.goldGradient)
            
            Text(todayDate)
                .font(.subheadline)
                .foregroundStyle(AppTheme.gold.opacity(0.7))
            
            Text("Tap any city to see its vibe")
                .font(.caption)
                .foregroundStyle(AppTheme.gold.opacity(0.5))
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [AppTheme.deepNavy.opacity(0.9), Color.black.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
    
    private var mapView: some View {
        ZStack {
            // Dark overlay to make map more mystical
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            Map(position: $position, interactionModes: [.pan, .zoom]) {
                ForEach(vibes) { vibe in
                    Annotation(vibe.localizedCityName, coordinate: CLLocationCoordinate2D(latitude: vibe.latitude, longitude: vibe.longitude)) {
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
            .mapStyle(.standard(elevation: .flat, emphasis: .muted, pointsOfInterest: .excludingAll, showsTraffic: false))
            .colorScheme(.dark)
            .opacity(0.85)
        }
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
                    Text(vibe.localizedCityName)
                        .font(AppTheme.serifFont(size: 22, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    Text(vibe.localizedCountryName)
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.gold.opacity(0.7))
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        selectedVibe = nil
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(AppTheme.gold.opacity(0.6))
                        .font(.title3)
                }
            }
            
            Divider()
                .background(AppTheme.gold.opacity(0.3))
            
            HStack(spacing: 16) {
                // Card image
                if let uiImage = UIImage(named: vibe.card.imageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 90)
                        .cornerRadius(8)
                        .shadow(color: AppTheme.gold.opacity(0.3), radius: 4)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AppTheme.darkNavy)
                        .frame(width: 60, height: 90)
                        .overlay {
                            Text("?")
                                .font(.largeTitle)
                                .foregroundStyle(AppTheme.gold)
                        }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(vibe.card.localizedName)
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text("\(vibe.percentage)% of readings today")
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.textSecondary)
                    
                    Button(action: {
                        showCardDetail = true
                    }) {
                        Text("View Card Details")
                            .font(.subheadline)
                            .foregroundStyle(AppTheme.gold)
                    }
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [AppTheme.darkNavy.opacity(0.95), AppTheme.deepNavy.opacity(0.98)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.5), radius: 20)
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
            }
        }
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
    }
}

#Preview {
    VibeCheckView()
}
