//
//  ReviewView.swift
//  MLB
//
//  Created by Avery Merlo on 4/24/23.
//

import SwiftUI
import Firebase

struct ReviewView: View {
    
    @State var spot: Stadium
    @State var review: Review
    @State var newReview = false
    @State var interactive = true
    @State var postedByThisUser = false
    @State private var rateOrReviewerString = "Click to rate:"
    @StateObject var reviewVM = ReviewViewModel()
    @Environment(\.dismiss) private var dismiss
    var color: Color
    
    var body: some View {
        VStack () {
            VStack(alignment: .leading) {
                Text(spot.name)
                    .font(.custom("Marker Felt", size: 24))
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .foregroundColor(color)
                Text(spot.address)
                    .font(.custom("Marker Felt", size: 18))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .padding(.bottom)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack (alignment: .center){
                HStack {
                    Spacer()
                    Text(rateOrReviewerString)
                        .font(postedByThisUser ? .custom("American Typewriter", size: 24) : .custom("American Typewriter", size: 14))
                        .bold(postedByThisUser)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(color)
                        .lineLimit(1)
                        .minimumScaleFactor(0.25)
                    .padding(.horizontal)
                    Spacer()
                }
                HStack {
                    StarsSelectionView(rating: $review.rating, interactive: true, fillColor: color)
                }
                .disabled(!postedByThisUser)
                .multilineTextAlignment(.center)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(color.opacity(0.5), lineWidth: postedByThisUser ? 2 : 0)
                }
            }
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Review Title:")
                    .bold()
                    .foregroundColor(color)
                TextField("title", text: $review.title)
                    .padding(.horizontal, 7.5)
                    .disabled(!postedByThisUser)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: postedByThisUser ? 2 : 0.3)
                    }
                Text("Review:")
                    .bold()
                    .foregroundColor(color)
                TextField("review", text: $review.body, axis: .vertical)
                    .disabled(!postedByThisUser)
                    .padding(.horizontal, 7.5)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: postedByThisUser ? 2 : 0.3)
                    }
            }
            .padding(.horizontal)
            .font(.custom("American Typewriter", size: 24))
            
            Spacer()
            
            
            
        }
        .onAppear {
            if review.reviewer == Auth.auth().currentUser?.email {
                postedByThisUser = true
            } else {
                let reviewPostedOn = review.postedOn.formatted(date: .numeric, time: .omitted)
                rateOrReviewerString = "by: \(review.reviewer) on: \(reviewPostedOn)"
            }
        }
        .navigationBarBackButtonHidden(postedByThisUser)
        .toolbar {
            
            if postedByThisUser {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            let success = await reviewVM.saveReview(spot: spot, review: review)
                            if success {
                                dismiss()
                            } else {
                                print("ERROR saving data in ReviewView.")
                            }
                        }
                    }
                }
                if review.id != nil {
                    ToolbarItemGroup (placement: .bottomBar) {
                        Spacer()
                        
                        Button {
                            Task {
                                let success = await reviewVM.deleteReview(spot: spot, review: review)
                                if success {
                                    dismiss()
                                }
                            }
                        } label: {
                            Image(systemName: "trash")
                                
                        }
                        .tint(color)

                    }
                }
            }
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReviewView(spot: Stadium(name: "Fenway Park", address: "4 Jersey St, Boston, MA 02215"), review: Review(), color: Color("Boston Red Sox - Color"))
        }
    }
}
