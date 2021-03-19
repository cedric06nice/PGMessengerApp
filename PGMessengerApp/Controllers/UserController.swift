//
//  UserController.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 11/03/2021.
//

import SwiftUI

class UserController {
    
    @AppStorage(Constants.AppStorage.token) var token: String?
    @ObservedObject var userManager: UserManager
    @ObservedObject var publicUsersManager: PublicUsersManager

    init(userManager: UserManager,
         publicUsersManager: PublicUsersManager) {
        self.userManager = userManager
        self.publicUsersManager = publicUsersManager
    }
    
    func create(name: String,
                email: String,
                password: String,
                passwordVerification: String) {
        self.userManager.errorMessage = ""
        if (password != "" && password != passwordVerification) {
            self.userManager.errorMessage = ServerError.badRequest("Both passwords must match!").localizedDescription
        }
        else {
            let userSignUp = UserSignUp(name: name, email: email, password: password)
            ApiController.createUser(user: userSignUp) { (result) in
                switch result {
                    case .success(let success):
                        DispatchQueue.main.async {
                            self.userManager.errorMessage = ""
                            self.userManager.user = success.user
                            self.token = success.token
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.userManager.errorMessage = ServerError.transportError(error).localizedDescription
                        }
                }
            }
        }
    }
    
    func login(name: String,
               password: String) {
        self.userManager.errorMessage = ""
        let userLogin = UserLogin(name: name, password: password)
        ApiController.logInUser(user: userLogin) { (result) in
            switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.userManager.errorMessage = ""
                        self.userManager.user = success.user
                        self.token = success.token
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.userManager.errorMessage = ServerError.transportError(error).localizedDescription
                    }
            }
        }
    }
    
    // MARK: TODO: Implement function to call for retrieving own user details
    func getOwnUser(token: String) { }
    
    func getAllUsers(token: String) {
        self.userManager.errorMessage = ""
        ApiController.getAllUsers(token: self.token ?? "") { (result) in
            switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.publicUsersManager.errorMessage = ""
                        self.publicUsersManager.publicUser = success
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.publicUsersManager.errorMessage = ServerError.noData.localizedDescription
                    }
            }
        }
    }
}
