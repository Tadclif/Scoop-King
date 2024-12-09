//
//  ScoopView.swift
//  Scoop King
//
//  Created by Tad Clifton on 12/3/24.
//
import SwiftUI
import FirebaseAuth

struct ScoopView: View {
    @StateObject private var scoopListVM = ScoopListViewModel()
    @State private var showRatingView = false
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    ZStack {
                        // Render scoops sorted by their rating
                        let sortedScoops = scoopListVM.scoops.sorted(by: { $0.rating > $1.rating })
                        // Render scoops
                        VStack(spacing: -120){
                            ForEach(Array(sortedScoops.enumerated()), id: \.element.id) { index, scoop in
                                ZStack {
                                    NavigationLink(
                                        destination: ScoopDetailView(
                                            scoop: scoop,
                                            onSave: { updatedScoop in
                                                Task {
                                                    await scoopListVM.updateScoop(updatedScoop)
                                                    await scoopListVM.fetchAllScoops() // Refresh after update
                                                }
                                            },
                                            onDelete: {
                                                Task {
                                                    await scoopListVM.deleteScoop(scoop)
                                                    await scoopListVM.fetchAllScoops() // Refresh after deletion
                                                }
                                            }
                                        )
                                    ) {
                                        // Scoop View
                                        IceCreamScoopView(scoop: scoop)
                                            .frame(width: 200, height: 200)
                                            .zIndex(Double(scoop.rating))  // Ensure higher scoops appear on top
                                            .onAppear {
                                                // Debugging: Print the zIndex values
                                                print("Scoop: \(scoop.flavor), Index: \(index), ZIndex: \(Double(scoop.rating))")
                                            }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            Image("emptycone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 300)
                                .zIndex(-100) // Always below scoops
                                .id("cone") // Unique ID for scrolling
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, geometry.size.height * 0.3) // Add padding above the scoops
                }
                .navigationTitle("Your Favorite Scoop")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showRatingView = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showRatingView = false }) {
                            Image(systemName: "arrow.right.square")
                                .font(.title3)
                        }
                    }
                    
                }
                .sheet(isPresented: $showRatingView) {
                    RatingView(
                        flavor: "",
                        rating: 3, // Initial rating for a new scoop
                        description: "",
                        onSave: { newScoop in
                            Task {
                                await scoopListVM.addScoop(newScoop)
                                await scoopListVM.fetchAllScoops() // Refresh the list after adding
                            }
                            showRatingView = false
                        },
                        onCancel: {
                            showRatingView = false
                        }
                    )
                }
            }
            .onAppear {
                
                Task {
                    await scoopListVM.fetchAllScoops() // Load scoops on view load
                    
                }
            }
        }
    }
    
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = UIHostingController(rootView: LoginView())
                window.makeKeyAndVisible()
            }
        } catch {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
    
    
}
#Preview {
    ScoopView()
}



