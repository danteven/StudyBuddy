//
//  extensionPublisher.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 21.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Combine

public extension Publisher {
    
    /// For use subscriptions with weak links
    /// - Parameter obj: subsriptions
    /// - Returns: Return subscriptions
    func withUnretained<Unretained: AnyObject>(
        _ obj: Unretained
    ) -> AnyPublisher<(obj: Unretained, value: Self.Output), Failure> {
        compactMap { [weak obj] value -> (obj: Unretained, value: Self.Output)? in
            guard let obj = obj else {
                return nil
            }
            return (obj: obj, value: value)
        }
        .eraseToAnyPublisher()
    }
    
    /// Use for subscribe with weak links
    /// - Parameter subject: Subscriptions
    /// - Returns: Return Subsribe of subscriptions
    func weakSubscribe<S>(_ subject: S) -> AnyCancellable where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output {
        return sink { [weak subject] error in
            subject?.send(completion: error)
        } receiveValue: { [weak subject] output in
            subject?.send(output)
        }
    }
}


public extension AnyPublisher {
    
    
    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            var finishedWithoutValue = true
            cancellable = first()
                .sink { result in
                    switch result {
                    case .finished:
                        guard finishedWithoutValue else { return }
                        continuation.resume(throwing: "Finished without value" as! Error)
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                } receiveValue: { value in
                    finishedWithoutValue = false
                    continuation.resume(with: .success(value))
                }
        }
    }
}
