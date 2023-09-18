//
//  ReusableClosure.swift
//  StudyBuddy
//
//  Created by Shamil Mazitov on 17.09.2023.
//

import Foundation

public typealias Closure<T> = (T) -> Void
public typealias EmptyClosure = () -> Void
public typealias BoolClosure = (Bool) -> Void
public typealias EmptyResultClosure = (Result<Void, Error>) -> Void
