//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Memo Figueredo on 28/1/26.
//

import UIKit

struct Constants {
  static let API_KEY = "f06be6bcababc93f2529c7384395a3cc"
  static let baseURL = "https://api.themoviedb.org"
  // https://api.themoviedb.org/3/trending/all/{time_window}
  //https://api.themoviedb.org/3/trending/all/day?api_key=<<api_key>>
}

enum APIError: Error {
  case failedTogetData
}


class APICaller {
  static let shared = APICaller()
  
  
  //getTrendingMovies(completion: @escaping (String) -> Void)
  func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
    guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
      guard let data = data, error == nil else {
        return
      }
      do {
        //donde dice TrendingMOviesResponse es el modelo
        let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
        completion(.success(results.results))
        /*try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
         print (results)*/
      } catch {
        completion(.failure(APIError.failedTogetData))
      }
    }
    task.resume()
  }
  
  
  func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
    guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
      guard let data = data, error == nil else {
        return
      }
      
      do {
        let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
        //JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        completion(.success(results.results))
      } catch {
        completion(.failure(APIError.failedTogetData))
      }
    }
    
    task.resume()
    
  }
  
  func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
    guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        return
      }
      
      do {
        let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
        completion(.success(results.results))
      } catch {
        completion(.failure(APIError.failedTogetData))
      }
    }
    task.resume()
  }
  
  func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
    guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        return
      }
      do {
        let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
        completion(.success(results.results))
      } catch {
        completion(.failure(APIError.failedTogetData))
      }
    }
    task.resume()
  }
  
  func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
    guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        return
      }
      do {
        let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
        completion(.success(results.results))
      } catch {
        completion(.failure(APIError.failedTogetData))
      }
    }
    task.resume()
  }
  
  
  
}

//https://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>&language=en-US&page=1

