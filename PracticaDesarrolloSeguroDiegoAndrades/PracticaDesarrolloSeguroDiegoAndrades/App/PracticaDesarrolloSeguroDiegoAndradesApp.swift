//
//  PracticaDesarrolloSeguroDiegoAndradesApp.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 18/5/24.
//

import SwiftUI

@main
struct PracticaDesarrolloSeguroDiegoAndradesApp: App {
    var body: some Scene {
        WindowGroup {
            let remoteDataSource = RemoteDataSourceImpl()
            let repository = RepositoryImpl(remoteDataSource: remoteDataSource)
            RootView()
                .environmentObject(RootViewModel(repository: repository))
        }
    }
}
