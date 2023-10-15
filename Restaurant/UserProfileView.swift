//
//  UserProfileView.swift
//  LittleLemonCap
//
//  Created by Illia Berezovskyi on 15/10/2023.
//

import SwiftUI

struct UserProfileView: View {
    let profileFirstName = UserDefaults.standard.string(forKey: Onboarding().someFirstName)
    let profileLastName = UserDefaults.standard.string(forKey: Onboarding().someLastName)
    let profileEmail = UserDefaults.standard.string(forKey: Onboarding().someEmail)
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(profileFirstName ?? "")
            Text(profileLastName ?? "")
            Text(profileEmail ?? "")
            
            Button("Logout", action: {
                UserDefaults.standard.setValue(false, forKey: Onboarding().kIsLoggedIn)
                self.presentation.wrappedValue.dismiss() // tells Swift to go back to previous screen and simulate the logout
            })
            Spacer()
        }
    }
}

#Preview {
    UserProfileView()
}
