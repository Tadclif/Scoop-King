//
//  LoginView.swift
//  Scoop King
//
//  Created by Tad Clifton on 12/3/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    enum Field {
        case email, password
    }
    
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var buttonsDisabled = true
    @State private var presentSheet = false
    @FocusState private var focusField: Field?
    
    var body: some View {
        VStack {
            Text("Scoop King")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.green)
                .padding()
            
            Image("scoopy")
                .resizable()
                .scaledToFit()
                .padding()
            
            Group {
                TextField("E-mail", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusField, equals: .email)
                    .onSubmit {
                        focusField = .password
                    }
                    .onChange(of: email) {
                        enableButtons()
                    }
                
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .focused($focusField, equals: .password)
                    .onSubmit {
                        focusField = nil
                    }
                    .onChange(of: password) {
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
                }
                .padding(.trailing)
                
                Button {
                   login()
                } label: {
                    Text("Log In")
                }
                .padding(.leading)
            }
            .disabled(buttonsDisabled)
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .font(.title2)
            .padding(.top)
        }
        .onAppear {
                        if Auth.auth().currentUser != nil {
                            print("🪵 Login Successful!")
                            presentSheet = false
                        }
                    }
                    .fullScreenCover(isPresented: $presentSheet) {
                        ScoopView()
                    }
        }
        
       
        
            func register() {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("😡 SIGN-UP ERROR: \(error.localizedDescription)")
                        alertMessage = "SIGN-UP ERROR: \(error.localizedDescription)"
                        showingAlert = true
                    } else {
                        print("😎 Registration success!")
                        presentSheet = true
                    }
                }
            }
        
            func login() {
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if let error = error { 
                        print("😡 LOGIN ERROR: \(error.localizedDescription)")
                        alertMessage = "LOGIN ERROR: \(error.localizedDescription)"
                        showingAlert = true
                    } else {
                        print("🪵 Login Successful!")
                        presentSheet = true
                    }
                }
    }
    
    func enableButtons() {
        let emailIsGood = email.count >= 6 && email.contains("@")
        let passwordIsGood = password.count >= 6
        buttonsDisabled = !(emailIsGood && passwordIsGood)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

