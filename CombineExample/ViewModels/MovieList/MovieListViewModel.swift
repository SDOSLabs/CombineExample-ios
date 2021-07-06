//
//  MovieListViewModel.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 7/6/21.
//

import Foundation
import Combine
import UIKit

final class MovieListViewModel {
    private static let searchDebounceStride: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(500)
    
    private let searchMoviesUseCase: SearchMoviesUseCaseProtocol
    private var movies = [Movie]()
    private var subscriptions = [AnyCancellable]()
    
    private var searchSubject = PassthroughSubject<MovieListState, Never>()
    private var searchSubscription: AnyCancellable?
    
    init(searchMoviesUseCase: SearchMoviesUseCaseProtocol) {
        self.searchMoviesUseCase = searchMoviesUseCase
    }
}

extension MovieListViewModel: MovieListViewModelProtocol {
    
    func bind(input: MovieListViewModelInput) -> MovieListViewModelOutput {
        let searchInput = input.search
            .debounce(for: Self.searchDebounceStride, scheduler: DispatchQueue.global())
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .removeDuplicates()
            .eraseToAnyPublisher()
        
        let validSearchInput = searchInput
            .filter { !$0.isEmpty }
            .eraseToAnyPublisher()
        
        let initialState = initialStateFor(searchInput: searchInput, cancelSearchInput: input.cancelSearch)
        let loadingState = loadingStateFor(validSearchInput: validSearchInput)
        let searchState = searchStateFor(validSearchInput: validSearchInput)
        
        let showDetail = showDetailOutputFor(input: input.selection)

        let state = Publishers.MergeMany(initialState, loadingState, searchState)
            .subscribe(on: DispatchQueue.global(qos: .userInteractive))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        return MovieListViewModelOutput(state: state, showDetail: showDetail)
    }
}

extension MovieListViewModel {
    
    private func searchStateFor(validSearchInput: AnyPublisher<String, Never>) -> AnyPublisher<MovieListState, Never> {
        validSearchInput.sink { [weak self] query in
            self?.search(by: query)
        }.store(in: &subscriptions)
        
        return searchSubject.eraseToAnyPublisher()
    }
    
    private func initialStateFor(searchInput: AnyPublisher<String, Never>,
                                 cancelSearchInput: AnyPublisher<Void, Never>) -> AnyPublisher<MovieListState, Never> {
        let initial = Just<MovieListState>(.initial)
            .eraseToAnyPublisher()
        
        let emptySearch: AnyPublisher<MovieListState, Never> = searchInput
            .filter { $0.isEmpty }
            .map { _ in .initial }
            .eraseToAnyPublisher()
    
        let cancelSearch: AnyPublisher<MovieListState, Never> = cancelSearchInput
            .map { _ in .initial }
            .eraseToAnyPublisher()
        
        let state = Publishers.MergeMany(initial, emptySearch, cancelSearch)
            .eraseToAnyPublisher()
        
        state.sink { [weak self] _ in
            self?.movies = []
            self?.searchSubscription?.cancel()
            self?.searchSubscription = nil
        }.store(in: &subscriptions)
        
        return state
    }
    
    private func loadingStateFor(validSearchInput: AnyPublisher<String, Never>) -> AnyPublisher<MovieListState, Never> {
        return validSearchInput
            .map { _ in .loading }
            .eraseToAnyPublisher()
    }
    
    private func showDetailOutputFor(input: AnyPublisher<Int, Never>) -> AnyPublisher<UIViewController, Never> {
        return input
            .compactMap { [weak self] index -> UIViewController? in
                guard let self = self else { return nil }
                let movie = self.movies[index]
                return ScreenBuilder.build(screen: .movieDetail(movie))
            }
            .eraseToAnyPublisher()
    }
    
    private func search(by query: String) {
        searchSubscription = searchMoviesUseCase.searchMovies(by: query)
            .compactMap { [weak self] movies in
                self?.movies = movies
                return movies.compactMap { MovieCellViewModel(movie: $0) }
            }
            .map { result -> MovieListState in
                return result.isEmpty ? .noResults : .success(result)
            }
            .catch { [weak self] error -> AnyPublisher<MovieListState, Never> in
                self?.movies = []
                return Just(.failure(error))
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
            .sink { [weak self] state in
                self?.searchSubject.send(state)
            }
    }
}
