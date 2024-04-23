//
//  ReusableSubscriptions.swift
//  Common
//
//  Created by Shamil Mazitov on 30.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import Combine

public typealias CurrentSubject<T> = CurrentValueSubject<T, Never>

public typealias VoidSubject = PassthroughSubject<Void, Never>
public typealias StringSubject = PassthroughSubject<String, Never>
public typealias IntSubject = PassthroughSubject<Int, Never>
public typealias CustomSubject<T> = PassthroughSubject<T, Never>

public typealias VoidPublisher = AnyPublisher<Void, Never>
public typealias StringPublisher = AnyPublisher<String, Never>
public typealias IntPublisher = AnyPublisher<Int, Never>
public typealias CustomPublisher<T> = AnyPublisher<T, Never>
