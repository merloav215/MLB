//
//  StadiumView.swift
//  MLB
//
//  Created by Avery Merlo on 4/18/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct StadiumView: View {
    
    @FirestoreQuery(collectionPath: "stadiums/") var reviews: [Review]
    var spot: Stadium
    var color: Color
    var color2 = Color(.black)
    
    @State private var favorited = false
    @State private var reviewListSheetIsPresented = false
    @State private var reviewSheetIsPresented = false
    
    var avgRating: String {
        guard reviews.count != 0 else {
            return "-.-"
        }
        let averageValue = Double(reviews.reduce(0) {$0 + $1.rating}) / (Double(reviews.count))
        return String(format: "%.1f", averageValue)
    }
    var previewRunning = false
    
    var body: some View {
        VStack(spacing: 2.5) {
            
            HStack {
                VStack(alignment: .leading) {
                    Text(spot.name)
                        .font(.custom("Marker Felt", size: 36))
                        .padding(.horizontal, 12.5)
                        .lineLimit(1)
                        .minimumScaleFactor(0.25)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(color)
                }
//                VStack (alignment: .trailing) {
//                    Button {
//                            favorited.toggle()
//                        } label: {
//                            Text(favorited ? "Favorited" : "Favorite")
//                                .foregroundColor(favorited ? .white : .white)
//                            Image(systemName: "star.fill")
//                                .foregroundColor(favorited ? .white : .white)
//                        }
//                        .buttonStyle(.borderedProminent)
//                        .tint(favorited ? color : .black)
//                    .padding(.horizontal, 12.5)
//                }
            }
            .padding(.bottom, 10.0)
            
            ScrollView(.vertical) {
                
                HStack {
                    Text("Holds: \(spot.capacity)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("Built: \(spot.builtIn)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal)
                }
                .font(.custom("American Typewriter", size: 20))
                .bold()
                .padding(.bottom, 2.5)
                .padding(.top, 12.5)
                
                Group {
                    VStack (alignment: .center) {
                        Text("Located in \(spot.city), \(spot.state)")
                            .font(.custom("American Typewriter", size: 20))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text("Home of the \(spot.team)")
                            .font(.custom("American Typewriter", size: 20))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .bold()
                    .padding(.bottom, 10.0)
                }
                
                Group {
                    VStack {
                        HStack {
                            Text("Reviews:")
                            Spacer()
                            Text("Average Rating:")
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("\(reviews.count)")
                                .foregroundColor(color)
                            Spacer()
                            Text(avgRating)
                                .foregroundColor(color)
                        }
                        .padding(.horizontal)
                    }
                    .font(.custom("American Typewriter", size: 20))
                    .bold()
                    VStack (alignment: .leading) {
                        HStack {
                            Button {
                                reviewListSheetIsPresented.toggle()
                            } label: {
                                Text("Reviews")
                                    .multilineTextAlignment(.leading)
                                Image(systemName: "baseball")
                            }
                            .multilineTextAlignment(.leading)
                            .buttonStyle(.borderedProminent)
                            .tint(color)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            Button {
                                reviewSheetIsPresented.toggle()
                            } label: {
                                Image(systemName: "note.text")
                                Text("Review Me")
                            }
                            .multilineTextAlignment(.leading)
                            .buttonStyle(.borderedProminent)
                            .tint(color)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        }
                    }
                }
                
                Group {
                    Image("\(spot.image)")
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 12.5)
                        .padding(.horizontal, 5.0)
                }
                .padding(.bottom, 25.0)
                
                Group {
                    
                    HStack {
                        Text("About \(spot.name):")
                            .padding(.horizontal)
                            .font(.custom("American Typewriter", size: 24))
                            .bold()
                            .lineLimit(1)
                            .minimumScaleFactor(0.25)
                            .padding(.bottom, 1.0)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Address:")
                            .padding(.horizontal)
                            .font(.custom("American Typewriter", size: 20))
                            .lineLimit(1)
                            .underline()
                            .minimumScaleFactor(0.25)
                            .padding(.bottom, 1.0)
                        Spacer()
                    }
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("\(spot.address)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.50)
                                .padding(.horizontal)
                                .font(.custom("American Typewriter", size: 20))
                                .foregroundColor(color)
                                .bold()
                        }
                        .padding(.bottom, 1)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Dimensions:")
                            .padding(.horizontal)
                            .font(.custom("American Typewriter", size: 20))
                            .lineLimit(1)
                            .underline()
                            .minimumScaleFactor(0.25)
                            .padding(.bottom, 1.0)
                        Spacer()
                    }
                    HStack {
                        Text("Left")
                        Spacer()
                        Text("Center Field")
                        Spacer()
                        Text("Right")
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.50)
                    .padding(.horizontal)
                    .font(.custom("American Typewriter", size: 20))
                    HStack {
                        Text("\(spot.left)")
                        Spacer()
                        Text("\(spot.center)")
                        Spacer()
                        Text("\(spot.right)")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 1.0)
                    .font(.custom("American Typewriter", size: 20))
                    .bold()
                    .foregroundColor(color)
                    
                    VStack {
                        HStack {
                            Text("Longest Home Run: ")
                                .padding(.horizontal)
                                .font(.custom("American Typewriter", size: 20))
                                .lineLimit(1)
                                .underline()
                                .minimumScaleFactor(0.25)
                            .padding(.bottom, 1.0)
                            Spacer()
                        }
                        HStack {
                            Text("\(spot.longestHR)")
                                .padding(.horizontal)
                                .padding(.bottom, 1.0)
                                .font(.custom("American Typewriter", size: 20))
                                .bold()
                                .foregroundColor(color)
                                .lineLimit(1)
                                .minimumScaleFactor(0.25)
                            .padding(.bottom, 1.0)
                            Spacer()
                        }
                        
                        Text("More coming soon...")
                            .font(.custom("Marker Felt", size: 36))
                            .padding(.horizontal, 12.5)
                            .lineLimit(1)
                            .minimumScaleFactor(0.25)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .padding(.top, 100.0)
                    }
                }
                
                Spacer()
            }
            
        }
        .onAppear {
            if !previewRunning {
                $reviews.path = "stadiums/\(spot.id ?? "")/reviews"
                print("reviews.path = \($reviews.path)")
            }
            
        }
        .sheet(isPresented: $reviewSheetIsPresented) {
            NavigationStack {
                ReviewView(spot: spot, review: Review(), newReview: true, color: color)
            }
        }
        .sheet(isPresented: $reviewListSheetIsPresented) {
            NavigationStack {
                ReviewListView(spot: spot, color: color)
            }
        }
    }
}

struct StadiumView_Previews: PreviewProvider {
    static var previews: some View {
        StadiumView(spot: Stadium(name: "Fenway Park", address: "4 Jersey St, Boston, MA 02215", builtIn: "1912", capacity: "35,755", city: "Boston", state: "MA", team: "Boston Red Sox", image: "redSoxImage"), color: Color("Boston Red Sox - Color"), previewRunning: true)
    }
}
