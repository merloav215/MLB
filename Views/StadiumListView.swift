//
//  ContentView.swift
//  MLB
//
//  Created by Avery Merlo on 4/18/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct StadiumListView: View {
    
    @FirestoreQuery(collectionPath: "stadiums") var spots: [Stadium]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack () {
            NavigationStack {
                List(spots) { stadium in
                    NavigationLink {
                        StadiumView(spot: stadium, color: Color("\(stadium.team) - Color"))
                    } label: {
                        Text(stadium.name)
                    }
                    .font(.custom("American Typewriter", size: 20))
                }
                .navigationTitle("MLB Stadiums")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Sign Out") {
                            do {
                                try Auth.auth().signOut()
                                print("Log Out Successful!")
                                dismiss()
                            } catch {
                                print("Error: Could not sign out!")
                            }
                        }
                    }
//                    ToolbarItem(placement: .bottomBar) {
//                        Button {
//                            //TODO: NAVIGATE TO FAVORITES
//                        } label: {
//                            Text("Favorites")
//                        }
//                    }
                }
                .font(.custom("Marker Felt", size: 20))
                .buttonStyle(.borderedProminent)
                .tint(Color("greenColor"))
            }
            .padding()
            .listStyle(.plain)
        }
    }
}
    

struct StadiumListView_Previews: PreviewProvider {
    static var previews: some View {
        StadiumListView()
    }
}
