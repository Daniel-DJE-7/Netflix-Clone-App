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
  static let youtubeAPI_key = "AIzaSyADsoQYnG_nRw-XaTkW0jWnMLqYLnHqCXQ"
  static let youtubeBaseURL = "https://www.googleapis.com/youtube/v3/search?part=snippet&"

  //======================
  //https://www.googleapis.com/youtube/v3/search?part=snippet&q=&type=video&key=TU_API_KEY
  //https://www.googleapis.com/youtube/v3/search?part=snippet&q=avengers&type=video&key=TU_API_KEY
  //https://www.googleapis.com/youtube/v3/search?part=snippet&q=liverpool&type=video&key=TU_API_KEY



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
  
  func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
    guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=es-ES&sort_by=popularity.desc&page=1") else { return }
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
  
  //
  func search (with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
    
    guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
    guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
      return }
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        return
      }
      do {
        let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
        print(results)
        completion(.success(results.results))
      } catch {
        completion(.failure(APIError.failedTogetData))
      }
    }
    task.resume()
  }
  
  
  func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
    guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&type=video&key=\(Constants.youtubeAPI_key)") else {
      return
    }
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        return
      }
      do {
//        let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
        completion(.success(results.items[0]))//accede al primer resultado del search el màs relevante
      } catch {
        completion(.failure(error))
        print(error.localizedDescription)
      }
    }
    task.resume()
  }
  
}



