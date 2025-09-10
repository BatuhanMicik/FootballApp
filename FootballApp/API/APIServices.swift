//
//  APIServices.swift
//  FootballApp
//
//  Created by Batuhan Mıcık on 7/8/25.
//
import Foundation

class APIServices {
    static let shared = APIServices()
    
    private init() {}
    
    enum APIError: Error {
        case invalidURL
        case noData
        case decodingError
    }
    
    
    func fetchFixtures(leagueId: Int, season: Int, completion: @escaping ([Fixture]) -> Void){
        guard let url = URL(string: "https://api-football-v1.p.rapidapi.com/v3/fixtures?league=\(leagueId)&season=\(season)") else {
            print("Invalid URL")
            completion([])
            return
        }
        
        
        let apiKey = getAPIKey()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("api-football-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No Data: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            
            }
            
            do {
                print(String(data: data, encoding: .utf8) ?? "Raw body not UTF-8")
                let decoded = try JSONDecoder().decode(FixtureResponse.self, from: data)
                
                completion(decoded.response)
        
            } catch {
                print("Decoding error: \(error)")
                completion([])
            }
        }.resume()
        
    }
    
    func fetchMatchEvents(fixtureId: Int, completion: @escaping (Result<[MatchEvent], Error>) -> Void){
        let urlString = "https://api-football-v1.p.rapidapi.com/v3/fixtures/events?fixture=\(fixtureId)"
        
        guard let url = URL(string: urlString) else{
            completion(.failure(APIError.invalidURL))
            return
        }
        let apiKey = getAPIKey()
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("api-football-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let data = data else{
                completion(.failure(APIError.noData))
                return
            }
            
            do{
                let decoded = try JSONDecoder().decode(MatchEventResponse.self, from: data)
                completion(.success(decoded.response))
            }catch{
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func fetchStatistics(fixtureId: Int, completion: @escaping (Result<[Stats], Error>) -> Void){
        let urlString = "https://api-football-v1.p.rapidapi.com/v3/fixtures/statistics?fixture=\(fixtureId)"
        
        guard let url = URL(string: urlString) else{
            completion(.failure(APIError.invalidURL))
            return
        }
        let apiKey = getAPIKey()
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("api-football-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let data = data else{
                completion(.failure(APIError.noData))
                return
            }
            
            do{
                let decoded = try JSONDecoder().decode(StatisticsResponse.self, from: data)
                completion(.success(decoded.response))
            }catch{
                completion(.failure(error))
            }
            
        }.resume()
    }
    
}
