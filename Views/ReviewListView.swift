//
//  ReviewListView.swift
//  MLB
//
//  Created by Avery Merlo on 4/25/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ReviewListView: View {
    
    @FirestoreQuery(collectionPath: "stadiums/") var reviews: [Review]
    var spot: Stadium
    var color: Color
    var previewRunning = false
    @Environment(\.dismiss) private var dismiss
    var avgRating: String {
        guard reviews.count != 0 else {
            return "-.-"
        }
        let averageValue = Double(reviews.reduce(0) {$0 + $1.rating}) / (Double(reviews.count))
        return String(format: "%.1f", averageValue)
    }
    
    var body: some View {
        ZStack() {
            
            VStack (alignment: .center) {
                Text("Reviews of \(spot.name)!")
                    .font(.custom("Marker Felt", size: 24))
                    .padding(.horizontal, 12.5)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(color)
                    .padding(.vertical, 20.0)
                
                HStack {
                    Text("Count: \(reviews.count)")
                    Spacer()
                    Text("Average Rating: \(avgRating)")
                }
                .font(.custom("Marker Felt", size: 20))
                .padding(.horizontal, 12.5)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                    
                List {
                    Section {
                        
                        if reviews.count == 0 {
                            HStack (alignment: .center) {
                                
                                Spacer()
                                
                                Text("No one has reviewed \(spot.name)...")
                                    .multilineTextAlignment(.center)
                                    .font(.custom("American Typewriter", size: 20))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                
                                Spacer()
                                
                            }
                        }
                        
                        ForEach(reviews) { review in
                            NavigationLink {
                                ReviewView(spot: spot, review: review, newReview: false, interactive: false, color: color)
                            } label: {
                                ReviewRowView(review: review, spot: spot, color: color)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if !previewRunning {
                $reviews.path = "stadiums/\(spot.id ?? "")/reviews"
                print("reviews.path = \($reviews.path)")
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Back to \(spot.name)") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(color)
            }
        }
    }
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView(spot: Stadium(name: "Fenway Park", address: "4 Jersey St, Boston, MA 02215", builtIn: "1912", capacity: "35,755", city: "Boston", state: "MA", team: "Boston Red Sox", image: "redSoxImage"), color: Color("Boston Red Sox - Color"), previewRunning: true)
    }
}
