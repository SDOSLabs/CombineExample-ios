//
//  AppDelegate.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

//import UIKit
import SwiftUI


@main
struct CombineExampleApp: App {
    var body: some Scene {
        WindowGroup {
            let dto = MovieDTO(id: 1, title: "El Club de la Lucha", overview: "This is an overview muy muy largo y tal y cual asdf adsf asdf as df asdf asdf asd f", poster: "https://picsum.photos/id/43/3000", releaseDate: "2020-01-01", genres: nil)
            let movie = Movie(from: dto)
            let vo = MovieCellVO(from: movie)
            
            let dto2 = MovieDTO(id: 1, title: "El Rey León", overview: "This is an overview muy muy largo y tal y cual asdf adsf asdf as df asdf asdf asd f", poster: "https://picsum.photos/id/43/3000", releaseDate: "2020-01-01", genres: nil)
            let movie2 = Movie(from: dto2)
            let vo2 = MovieCellVO(from: movie2)
            
            MovieListView(movies: [vo, vo2])
        }
    }
}

//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//
//        let viewController = ScreenBuilder.build(screen: .movieList)
//        window?.rootViewController = UINavigationController(rootViewController: viewController)
//        window?.makeKeyAndVisible()
//
//        return true
//    }
//}
