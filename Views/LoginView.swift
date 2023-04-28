//
//  LoginView.swift
//  MyStadium
//
//  Created by Avery Merlo on 3/27/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    enum Field {
        case email, password
    }
    
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var buttonDisabled = true
    @State private var presentSheet = false
    @FocusState private var FocusField: Field?
    
    var body: some View {
        VStack {
            Text("MyStadium")
                .foregroundColor(Color("greenColor"))
                .font(.custom("American Typewriter", size: 48))
                .padding(15.0)
                .bold()
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("brownColor"), lineWidth: 7.5)
                }
            Image("launchScreen")
                .resizable()
                .scaledToFit()
            
            VStack {
                Text("Explore all 30 Major League Parks!")
                    .font(.custom("Marker Felt", size: 24))
                    .lineLimit(1)
                    .padding(.all, 5.0)
                    .minimumScaleFactor(0.5)
                    .bold()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color("brownColor"), lineWidth: 2.5)
                    }
                    .padding(.horizontal)
            }
            .padding(.bottom)
            
            Group {
                TextField("E-Mail", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($FocusField, equals: .email)
                    .onSubmit {
                        FocusField = .password
                    }
                    .onChange(of: email) { _ in
                        enableButtons()
                    }
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .focused($FocusField, equals: .password)
                    .onSubmit {
                        FocusField = nil
                    }
                    .onChange(of: password) { _ in
                        enableButtons()
                    }
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            
            HStack {
                Button {
                    register()
                } label: {
                    Text("Sign Up")
                        .font(.custom("Marker Felt", size: 24))
                }
                .padding(.trailing)
                Button {
                    login()
                } label: {
                    Text("Log In")
                        .font(.custom("Marker Felt", size: 24))
                }
                .padding(.leading)
            }
            .disabled(buttonDisabled)
            .buttonStyle(.borderedProminent)
            .tint(Color("greenColor"))
            .font(.title2)
            .padding(.top)
            .alert(alertMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            .onAppear {
                if Auth.auth().currentUser != nil {
                    print("Login Success!")
                    presentSheet = true
                }
            }
            .fullScreenCover(isPresented: $presentSheet) {
                StadiumListView()
            }
        }
    }
    
    func enableButtons() {
        let emailIsGood = email.count >= 6 && email.contains("@")
        let passwordIsGood = password.count >= 6
        buttonDisabled = !(emailIsGood && passwordIsGood)
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("SIGNUP Error: \(error.localizedDescription)!")
                alertMessage = "SIGNUP Error: \(error.localizedDescription)!"
                showingAlert = true
            } else {
                print("Registration Success!")
                presentSheet = true
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("LOGIN Error: \(error.localizedDescription)!")
                alertMessage = "LOGIN Error: \(error.localizedDescription)!"
                showingAlert = true
            } else {
                print("Login Success!")
                presentSheet = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
