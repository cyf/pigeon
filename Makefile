
get:
	echo "╠ Installing dependencies..."
	flutter pub get

outdated:
	echo "╠ Resolving dependencies..."
	flutter pub outdated

clean: ## Cleans the environment
	echo "╠ Cleaning the project..."
	flutter clean
	echo "╠ Installing dependencies..."
	flutter pub get

icon: ## Generate icons
	echo "╠ Generate icons..."
	dart run flutter_native_splash:create

build_watch: ## Watches the files for changes
	echo "╠ Watching the project..."
	dart run build_runner watch --delete-conflicting-outputs

build_runner: ## Build the files for changes
	echo "╠ Building the project..."
	dart run build_runner build --delete-conflicting-outputs

clean_runner: ## Deleting cache and generated source files
	echo "╠ Deleting cache and generated source files..."
	dart run build_runner clean

apk: ## Release Apk
	echo "╠ Releasing Apk..."
	bash build-android.sh && flutter build apk --no-tree-shake-icons --target lib/main.dart

appbundle_firebase: ## Release Appbundle
	echo "╠ Releasing Appbundle..."
	bash build-android.sh && flutter build appbundle --no-tree-shake-icons --target lib/main.dart

appbundle: ## Release Appbundle
	echo "╠ Releasing Appbundle..."
	rm -f android/git.properties && flutter build appbundle --no-tree-shake-icons --target lib/main.dart

ad_hoc:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to pgyer..."
	bash build-ios.sh && flutter build ipa --release --export-options-plist=ios/ExportOptions-debug.plist --dart-define-from-file=ios-pgyer.json

app_store:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to app store..."
	flutter build ipa --release --export-options-plist=ios/ExportOptions-release.plist
