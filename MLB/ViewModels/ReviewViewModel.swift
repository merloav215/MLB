//
//  ReviewViewModel.swift
//  MLB
//
//  Created by Avery Merlo on 4/24/23.
//

import Foundation
import FirebaseFirestore

class ReviewViewModel: ObservableObject {
    
    @Published var review = Review()
    
    func saveReview(spot: Stadium, review: Review) async -> Bool {
        let db = Firestore.firestore()
        
        guard let spotID = spot.id else {
            print("ERROR: spot.id == nil")
            return false
        }
        
        let collectionString = "stadiums/\(spotID)/reviews"
        
        if let id = review.id {
            do {
                try await db.collection(collectionString).document(id).setData(review.dictionary)
                print("Data uploaded successfully!")
                return true
            } catch {
                print("ERROR: could not upload data in 'stadiums' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
                _ = try await db.collection(collectionString).addDocument(data: review.dictionary)
                print("Data uploaded successfully!")
                return true
            } catch {
                print("ERROR: could not create a new review in 'reviews' \(error.localizedDescription)")
                return false
            }
        }
    }
    
    func deleteReview(spot: Stadium, review: Review) async -> Bool {
        let db = Firestore.firestore()
        
        guard let spotID = spot.id, let reviewID = review.id else {
            print("ERROR: spot.id == \(spot.id), review.id == \(review.id). That was not supposed to happen.")
            return false
        }
        
        do {
            let _ = try await db.collection("stadiums").document(spotID).collection("reviews").document(reviewID).delete()
            print("Document successfully deleted.")
            return true
        } catch {
            print("ERROR: could not remove review \(error.localizedDescription)")
            return false
        }
        
    }
}
