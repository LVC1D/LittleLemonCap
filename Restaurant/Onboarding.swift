//
//  Onboarding.swift
//  LittleLemonCap
//
//  Created by Illia Berezovskyi on 15/10/2023.
//

import SwiftUI

struct Onboarding: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var emailIsValid: Bool = true
    @State var isLoggedIn = false
    
    let someFirstName = "Dude"
    let someLastName = "Bronston"
    let someEmail = "sonicdude@yo.com"
    let kIsLoggedIn = "kIsLoggedIn"
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                    return EmptyView()
                }
                
                TextField("First Name:", text: $firstName)
                TextField("Last Name:", text: $lastName)
                TextField("Email:", text: $email)
                   
                Button("Register", action: {
                    
                    if !firstName.isEmpty && !lastName.isEmpty &&
                        !email.isEmpty && email.contains("@") {
                        
                        UserDefaults.standard.set(firstName, forKey: someFirstName)
                        UserDefaults.standard.set(lastName, forKey: someLastName)
                        UserDefaults.standard.set(email, forKey: someEmail)
                        
                        emailIsValid = true
                        isLoggedIn = true
                        
                        UserDefaults().setValue(true, forKey: kIsLoggedIn)
                        
                    } else {
                        emailIsValid = false
                        print("Please check that the credentials are correct")
                    }
                })
                .onAppear() {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) == true {
                        isLoggedIn = true
                    }
                }
            }
        }
    }
}



#Preview {
    Onboarding()
}

