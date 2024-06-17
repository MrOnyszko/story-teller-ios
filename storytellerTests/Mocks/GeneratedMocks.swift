// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import MockSwift
@testable import storyteller

















// MARK: - AddStoryTranslationUseCase
extension Mock: AddStoryTranslationUseCase where WrappedType == AddStoryTranslationUseCase {
  public func execute(storyId: String, title: String, content: String, languageCode: String) throws -> StoryTranslation {
    try mockedThrowable(storyId, title, content, languageCode)
  }
}

extension Given where WrappedType == AddStoryTranslationUseCase {
  public func execute(storyId: MockSwift.Predicate<String>, title: MockSwift.Predicate<String>, content: MockSwift.Predicate<String>, languageCode: MockSwift.Predicate<String>) -> Mockable<StoryTranslation> {
    mockable(storyId, title, content, languageCode)
  }
  public func execute(storyId: String, title: String, content: String, languageCode: String) -> Mockable<StoryTranslation> {
    mockable(storyId, title, content, languageCode)
  }
}

extension Then where WrappedType == AddStoryTranslationUseCase {
  public func execute(storyId: MockSwift.Predicate<String>, title: MockSwift.Predicate<String>, content: MockSwift.Predicate<String>, languageCode: MockSwift.Predicate<String>) -> Verifiable<StoryTranslation> {
    verifiable(storyId, title, content, languageCode)
  }
  public func execute(storyId: String, title: String, content: String, languageCode: String) -> Verifiable<StoryTranslation> {
    verifiable(storyId, title, content, languageCode)
  }
}

// MARK: - AddStoryUseCase
extension Mock: AddStoryUseCase where WrappedType == AddStoryUseCase {
  public func execute(title: String, content: String, languageCode: String) throws -> Story {
    try mockedThrowable(title, content, languageCode)
  }
}

extension Given where WrappedType == AddStoryUseCase {
  public func execute(title: MockSwift.Predicate<String>, content: MockSwift.Predicate<String>, languageCode: MockSwift.Predicate<String>) -> Mockable<Story> {
    mockable(title, content, languageCode)
  }
  public func execute(title: String, content: String, languageCode: String) -> Mockable<Story> {
    mockable(title, content, languageCode)
  }
}

extension Then where WrappedType == AddStoryUseCase {
  public func execute(title: MockSwift.Predicate<String>, content: MockSwift.Predicate<String>, languageCode: MockSwift.Predicate<String>) -> Verifiable<Story> {
    verifiable(title, content, languageCode)
  }
  public func execute(title: String, content: String, languageCode: String) -> Verifiable<Story> {
    verifiable(title, content, languageCode)
  }
}

// MARK: - GetLanguagesUseCase
extension Mock: GetLanguagesUseCase where WrappedType == GetLanguagesUseCase {
  public func execute() throws -> [String] {
    try mockedThrowable()
  }
}

extension Given where WrappedType == GetLanguagesUseCase {
  public func execute() -> Mockable<[String]> {
    mockable()
  }
}

extension Then where WrappedType == GetLanguagesUseCase {
  public func execute() -> Verifiable<[String]> {
    verifiable()
  }
}

// MARK: - GetStoriesUseCase
extension Mock: GetStoriesUseCase where WrappedType == GetStoriesUseCase {
  public func execute() throws -> [Story] {
    try mockedThrowable()
  }
}

extension Given where WrappedType == GetStoriesUseCase {
  public func execute() -> Mockable<[Story]> {
    mockable()
  }
}

extension Then where WrappedType == GetStoriesUseCase {
  public func execute() -> Verifiable<[Story]> {
    verifiable()
  }
}

// MARK: - GetStoryUseCase
extension Mock: GetStoryUseCase where WrappedType == GetStoryUseCase {
  public func execute(storyId: String) throws -> GetStoryResult {
    try mockedThrowable(storyId)
  }
}

extension Given where WrappedType == GetStoryUseCase {
  public func execute(storyId: MockSwift.Predicate<String>) -> Mockable<GetStoryResult> {
    mockable(storyId)
  }
  public func execute(storyId: String) -> Mockable<GetStoryResult> {
    mockable(storyId)
  }
}

extension Then where WrappedType == GetStoryUseCase {
  public func execute(storyId: MockSwift.Predicate<String>) -> Verifiable<GetStoryResult> {
    verifiable(storyId)
  }
  public func execute(storyId: String) -> Verifiable<GetStoryResult> {
    verifiable(storyId)
  }
}

// MARK: - RemoveStoryUseCase
extension Mock: RemoveStoryUseCase where WrappedType == RemoveStoryUseCase {
  public func execute(storyId: String) throws {
    try mockedThrowable(storyId)
  }
}

extension Given where WrappedType == RemoveStoryUseCase {
  public func execute(storyId: MockSwift.Predicate<String>) -> Mockable<Void> {
    mockable(storyId)
  }
  public func execute(storyId: String) -> Mockable<Void> {
    mockable(storyId)
  }
}

extension Then where WrappedType == RemoveStoryUseCase {
  public func execute(storyId: MockSwift.Predicate<String>) -> Verifiable<Void> {
    verifiable(storyId)
  }
  public func execute(storyId: String) -> Verifiable<Void> {
    verifiable(storyId)
  }
}

// MARK: - StoriesDataSource
extension Mock: StoriesDataSource where WrappedType == StoriesDataSource {
  public func languages() throws -> [String] {
    try mockedThrowable()
  }
  public func getStories() throws -> [Story] {
    try mockedThrowable()
  }
  public func getStory(id: String) throws -> Story? {
    try mockedThrowable(id)
  }
  public func getStoryTranslations(storyId: String) throws -> [StoryTranslation] {
    try mockedThrowable(storyId)
  }
  public func addStory(title: String, content: String, languageCode: String) throws -> Story {
    try mockedThrowable(title, content, languageCode)
  }
  public func addTranslation(storyId: String, langaugeCode: String, title: String, content: String) throws -> StoryTranslation {
    try mockedThrowable(storyId, langaugeCode, title, content)
  }
  public func removeStory(storyId: String) throws {
    try mockedThrowable(storyId)
  }
}

extension Given where WrappedType == StoriesDataSource {
  public func languages() -> Mockable<[String]> {
    mockable()
  }
  public func getStories() -> Mockable<[Story]> {
    mockable()
  }
  public func getStory(id: MockSwift.Predicate<String>) -> Mockable<Story?> {
    mockable(id)
  }
  public func getStory(id: String) -> Mockable<Story?> {
    mockable(id)
  }
  public func getStoryTranslations(storyId: MockSwift.Predicate<String>) -> Mockable<[StoryTranslation]> {
    mockable(storyId)
  }
  public func getStoryTranslations(storyId: String) -> Mockable<[StoryTranslation]> {
    mockable(storyId)
  }
  public func addStory(title: MockSwift.Predicate<String>, content: MockSwift.Predicate<String>, languageCode: MockSwift.Predicate<String>) -> Mockable<Story> {
    mockable(title, content, languageCode)
  }
  public func addStory(title: String, content: String, languageCode: String) -> Mockable<Story> {
    mockable(title, content, languageCode)
  }
  public func addTranslation(storyId: MockSwift.Predicate<String>, langaugeCode: MockSwift.Predicate<String>, title: MockSwift.Predicate<String>, content: MockSwift.Predicate<String>) -> Mockable<StoryTranslation> {
    mockable(storyId, langaugeCode, title, content)
  }
  public func addTranslation(storyId: String, langaugeCode: String, title: String, content: String) -> Mockable<StoryTranslation> {
    mockable(storyId, langaugeCode, title, content)
  }
  public func removeStory(storyId: MockSwift.Predicate<String>) -> Mockable<Void> {
    mockable(storyId)
  }
  public func removeStory(storyId: String) -> Mockable<Void> {
    mockable(storyId)
  }
}

extension Then where WrappedType == StoriesDataSource {
  public func languages() -> Verifiable<[String]> {
    verifiable()
  }
  public func getStories() -> Verifiable<[Story]> {
    verifiable()
  }
  public func getStory(id: MockSwift.Predicate<String>) -> Verifiable<Story?> {
    verifiable(id)
  }
  public func getStory(id: String) -> Verifiable<Story?> {
    verifiable(id)
  }
  public func getStoryTranslations(storyId: MockSwift.Predicate<String>) -> Verifiable<[StoryTranslation]> {
    verifiable(storyId)
  }
  public func getStoryTranslations(storyId: String) -> Verifiable<[StoryTranslation]> {
    verifiable(storyId)
  }
  public func addStory(title: MockSwift.Predicate<String>, content: MockSwift.Predicate<String>, languageCode: MockSwift.Predicate<String>) -> Verifiable<Story> {
    verifiable(title, content, languageCode)
  }
  public func addStory(title: String, content: String, languageCode: String) -> Verifiable<Story> {
    verifiable(title, content, languageCode)
  }
  public func addTranslation(storyId: MockSwift.Predicate<String>, langaugeCode: MockSwift.Predicate<String>, title: MockSwift.Predicate<String>, content: MockSwift.Predicate<String>) -> Verifiable<StoryTranslation> {
    verifiable(storyId, langaugeCode, title, content)
  }
  public func addTranslation(storyId: String, langaugeCode: String, title: String, content: String) -> Verifiable<StoryTranslation> {
    verifiable(storyId, langaugeCode, title, content)
  }
  public func removeStory(storyId: MockSwift.Predicate<String>) -> Verifiable<Void> {
    verifiable(storyId)
  }
  public func removeStory(storyId: String) -> Verifiable<Void> {
    verifiable(storyId)
  }
}

// MARK: - TranslateTextUseCase
extension Mock: TranslateTextUseCase where WrappedType == TranslateTextUseCase {
  public func execute(model: String, text: String, languageCode: String) throws -> String {
    try mockedThrowable(model, text, languageCode)
  }
}

extension Given where WrappedType == TranslateTextUseCase {
  public func execute(model: MockSwift.Predicate<String>, text: MockSwift.Predicate<String>, languageCode: MockSwift.Predicate<String>) -> Mockable<String> {
    mockable(model, text, languageCode)
  }
  public func execute(model: String, text: String, languageCode: String) -> Mockable<String> {
    mockable(model, text, languageCode)
  }
}

extension Then where WrappedType == TranslateTextUseCase {
  public func execute(model: MockSwift.Predicate<String>, text: MockSwift.Predicate<String>, languageCode: MockSwift.Predicate<String>) -> Verifiable<String> {
    verifiable(model, text, languageCode)
  }
  public func execute(model: String, text: String, languageCode: String) -> Verifiable<String> {
    verifiable(model, text, languageCode)
  }
}

