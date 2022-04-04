//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2021-2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

// MARK: `CollectionSearcher` algorithms

extension Collection {
  func contains<Searcher: CollectionSearcher>(
    _ searcher: Searcher
  ) -> Bool where Searcher.Searched == Self {
    firstRange(of: searcher) != nil
  }
}

// MARK: Fixed pattern algorithms

extension Collection where Element: Equatable {
  /// Returns a Boolean value indicating whether the collection contains the
  /// given sequence.
  /// - Parameter other: A sequence to search for within this collection.
  /// - Returns: `true` if the collection contains the specified sequence,
  /// otherwise `false`.
  public func contains<S: Sequence>(_ other: S) -> Bool
    where S.Element == Element
  {
    firstRange(of: other) != nil
  }
}

extension BidirectionalCollection where Element: Comparable {
  func contains<S: Sequence>(_ other: S) -> Bool
    where S.Element == Element
  {
    firstRange(of: other) != nil
  }
}

// MARK: Regex algorithms

extension BidirectionalCollection where SubSequence == Substring {
  /// Returns a Boolean value indicating whether the collection contains the
  /// given regex.
  /// - Parameter regex: A regex to search for within this collection.
  /// - Returns: `true` if the regex was found in the collection, otherwise
  /// `false`.

  public func contains<R: RegexComponent>(_ regex: R) -> Bool {
    contains(RegexConsumer(regex))
  }
}
