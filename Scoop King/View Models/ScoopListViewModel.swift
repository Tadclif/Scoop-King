//
//  ScoopListViewModel.swift
//  Scoop King
//
//  Created by Tad Clifton on 12/3/24.
//

import FirebaseFirestore
import FirebaseAuth

class ScoopListViewModel: ObservableObject {
    @Published var scoops: [IceCreamScoop] = []
    private let db = Firestore.firestore()

    
    func fetchAllScoops() async {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("No user is logged in.")
            return
        }
        do {
            let snapshot = try await db.collection("users").document(userUID).collection("scoops").getDocuments()
            
            let fetchedScoops = snapshot.documents.compactMap { document -> IceCreamScoop? in
                var scoop = try? document.data(as: IceCreamScoop.self)
                scoop?.id = document.documentID 
                return scoop
            }
            
            DispatchQueue.main.async {
                self.scoops = fetchedScoops
                print("Fetched Scoops for user \(userUID): \(self.scoops.map { $0.flavor })")
            }
        } catch {
            print("Error fetching scoops: \(error.localizedDescription)")
        }
    }

    
    func addScoop(_ scoop: IceCreamScoop) async {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("No user is logged in.")
            return
        }
        do {
            let newScoop = scoop
            try await db.collection("users").document(userUID).collection("scoops").addDocument(data: newScoop.dictionary)
        } catch {
            print("Error adding scoop: \(error.localizedDescription)")
        }
    }

    
    func updateScoop(_ updatedScoop: IceCreamScoop) async {
        guard let userUID = Auth.auth().currentUser?.uid, let scoopID = updatedScoop.id else {
            print("Missing user UID or scoop ID.")
            return
        }
        do {
            try await db.collection("users").document(userUID).collection("scoops").document(scoopID).setData(updatedScoop.dictionary)
        } catch {
            print("Error updating scoop: \(error.localizedDescription)")
        }
    }

    
    func deleteScoop(_ scoop: IceCreamScoop) async {
        guard let userUID = Auth.auth().currentUser?.uid, let scoopID = scoop.id else {
            print("Missing user UID or scoop ID.")
            return
        }
        do {
            try await db.collection("users").document(userUID).collection("scoops").document(scoopID).delete()
        } catch {
            print("Error deleting scoop: \(error.localizedDescription)")
        }
    }
}
