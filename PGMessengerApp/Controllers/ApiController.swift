//
//  ApiController.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 11/03/2021.
//

import SwiftUI

class ApiController {
        
    static var apiUrl:String = "\(Secrets.Server.serverProtocol)://\(Secrets.Server.hostname):\(Secrets.Server.port)"
    
    // MARK: Users
    static func createUser(url: String = apiUrl,
                           path: String = "/users/signup",
                           user: UserSignUp,
                           completion: @escaping (Result<Session, Error>) -> ()) {
        
        guard let jsonData = try? JSONEncoder().encode(user) else { return }
        guard let url = URL(string: url+path) else { return }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        req.httpBody = jsonData
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            if let error = error { completion(.failure(ServerError.transportError(error))) }
            
            if let response = response as? HTTPURLResponse {
                
                guard let data = data else { completion(.failure(ServerError.noData)); return }
                let statusCode = response.statusCode
                switch statusCode {
                    
                case 200: //OK
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let session = try decoder.decode(Session.self, from: data)
                        completion(.success(session))
                    } catch { completion(.failure(ServerError.jsonDecodeFailed("Session"))) }
                    
                case 400: // Duplicate
                    do {
                        let duplicate = try JSONDecoder().decode(ReturnedServerErrors.self, from: data)
                        completion(.failure(ServerError.duplicate(duplicate.reason)))
                    } catch { completion(.failure(ServerError.unknown)) }
                
                case 409: // Conflict
                    do {
                        let conflict = try JSONDecoder().decode(ReturnedServerErrors.self, from: data)
                        completion(.failure(ServerError.conflict(conflict.reason)))
                    } catch { completion(.failure(ServerError.unknown)) }
                
                default:
                    completion(.failure(ServerError.serverSideError(statusCode)))
                }
            }
        }
        .resume()
    }
    
    static func logInUser(url: String = apiUrl,
                          path: String = "/users/login",
                          user: UserLogin,
                          completion: @escaping (Result<Session, Error>) -> ()) {
        
        let loginString = String(format: "%@:%@", user.name, user.password)
        guard let loginData = loginString.data(using: String.Encoding.utf8)
            else { completion(.failure(ServerError.jsonDecodeFailed("LoginString"))); return }
        let base64LoginString = loginData.base64EncodedString()
        guard let url = URL(string: url+path) else { return }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            if let error = error { completion(.failure(ServerError.transportError(error))) }
            
            if let response = response as? HTTPURLResponse {
                
                guard let data = data else { completion(.failure(ServerError.noData)); return }
                let statusCode = response.statusCode
                switch statusCode {
                    
                case 200: //OK
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let session = try decoder.decode(Session.self, from: data)
                        completion(.success(session))
                    } catch { completion(.failure(ServerError.jsonDecodeFailed("Session"))) }
                    
                case 401: // Unauthorized
                    do {
                        let error = try JSONDecoder().decode(ReturnedServerErrors.self, from: data)
                        completion(.failure(ServerError.conflict(error.reason)))
                    } catch { completion(.failure(ServerError.unknown)) }
                
                default:
                    completion(.failure(ServerError.serverSideError(statusCode)))
                }
            }
        }
        .resume()
    }
    
    // MARK: TODO: Implement function to call API for retrieving own user details
    static func getOwnUser(url: String = apiUrl,
                            path: String = "/users/me",
                            token: String,
                            completion: @escaping (Result<OwnUser, Error>) -> ()) { }
    
    static func getAllUsers(url: String = apiUrl,
                            path: String = "/users/all-users",
                            token: String,
                            completion: @escaping (Result<[PublicUser], Error>) -> ()) {
        
        guard let url = URL(string: url+path) else { return }
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                
                guard let data = data else { completion(.failure(ServerError.noData)); return }
                let statusCode = response.statusCode
                switch statusCode {
                    
                case 200: //OK
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let publicUsers = try decoder.decode([PublicUser].self, from: data)
                        completion(.success(publicUsers))
                    } catch { completion(.failure(ServerError.jsonDecodeFailed("[PublicUser]"))) }
                
                default:
                    completion(.failure(ServerError.serverSideError(statusCode)))
                }
            }
        }
        .resume()
    }
    
    // MARK: Messages
    static func getAllMessages(url: String = apiUrl,
                               path: String = "/messages/all-messages",
                               token: String,
                               completion: @escaping (Result<[Message], Error>) -> ()) {
        
        guard let url = URL(string: url+path) else { return }
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                
                guard let data = data else { completion(.failure(ServerError.noData)); return }
                let statusCode = response.statusCode
                switch statusCode {
                    
                case 200: //OK
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let messages = try decoder.decode([Message].self, from: data)
                        completion(.success(messages))
                    } catch { completion(.failure(ServerError.jsonDecodeFailed("[Message]"))) }
                
                default:
                    completion(.failure(ServerError.serverSideError(statusCode)))
                }
            }
        }
        .resume()
    }
    
    // MARK: TODO: Implement function to call API for posting a new message on the chat
    static func postNewMessage(url: String = apiUrl,
                               path: String = "/messages/new-message",
                               token: String,
                               message: String,
                               completion: @escaping (Result<Message, Error>) -> ()) {}
}
