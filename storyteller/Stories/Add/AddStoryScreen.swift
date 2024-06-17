import Foundation
import SwiftUI
import Translation

struct AddStoryScreen: View {
    @EnvironmentObject var router: GoRouter
    @ObservedObject var viewModel: AddStoryViewModel
    
    var body: some View {
        AddStoryContent(
            state: viewModel.state,
            languagePickerBinding: $viewModel.state.langauge,
            titleBinding: $viewModel.state.title,
            contentBinding: $viewModel.state.content,
            onSavePressed: viewModel.save,
            onTranslatePressed: viewModel.translate,
            onLanguageChange: viewModel.filterTranslations
        )
        .onReceive(viewModel.didSaveStory) { _ in
            router.back()
        }
        .onAppear(perform: viewModel.load)
    }
}

struct AddStoryContent: View {
    var state: AddStoryState
    
    var languagePickerBinding: Binding<NSLocale>
    var titleBinding: Binding<String>
    var contentBinding: Binding<String>
    var onSavePressed: () -> Void
    var onTranslatePressed: (TranslaionItem) -> Void
    var onLanguageChange: (NSLocale) -> Void
    
    var body: some View {
        Form {
            Section(
                header: Text("story_label"),
                content: {
                    Picker("language_label", selection: languagePickerBinding) {
                        ForEach(state.languages, id: \.self) { language in
                            Text(language.languageCode)
                        }
                    }
                    .onChange(of: state.langauge) { oldValue, newValue in
                        onLanguageChange(newValue)
                    }
                    TextField("story_title_input", text: titleBinding)
                    TextField("story_content_input", text: contentBinding, axis: .vertical)
                }
            )

            Section(header: Text("translations_label")) {
                ForEach(state.translations) { translation in
                    HStack {
                        VStack(
                            alignment: .leading,
                            content: {
                                Text(translation.title)
                                    .font(.headline)
                                Text(translation.content)
                                    .font(.footnote)
                                Text(translation.languageCode)
                                    .font(.caption)
                            }
                        )
                        Spacer()
                        Button(
                            action: {
                                onTranslatePressed(translation)
                            },
                            label: {
                                if state.isTranslating {
                                    ProgressView()
                                } else {
                                    Text("translate_button")
                                }
                            }
                        )
                        .disabled(state.isTranslateDisabled)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(
                placement: .navigationBarTrailing,
                content: {
                    Button(
                        action: onSavePressed,
                        label: {
                            Text("save_button")
                        }
                    )
                    .disabled(state.isSaveDisabled)
                }
            )
        }
        .navigationTitle("add_story_screen_title")
    }
}

#Preview {
    NavigationStack {
        AddStoryContent(
            state: AddStoryState(),
            languagePickerBinding: Binding.constant( NSLocale(localeIdentifier: "en")),
            titleBinding: Binding.constant(""),
            contentBinding: Binding.constant(""),
            onSavePressed: {},
            onTranslatePressed: { _ in },
            onLanguageChange: { _ in }
        )
    }
}
