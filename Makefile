
get:
	echo "╠ Installing dependencies..."
	flutter pub get
	make ios_install

outdated:
	echo "╠ Resolving dependencies..."
	flutter pub outdated

clean: ## Cleans the environment
	echo "╠ Cleaning the project..."
	flutter clean
	echo "╠ Installing dependencies..."
	flutter pub get

npm_install: ## Installing npm dependencies
	echo "╠ Resolving npm dependencies..."
	cd node && pnpm i && cd ..

ios_install: ## Installing ios dependencies
	echo "╠ Resolving ios dependencies..."
	cd ios && pod install && cd ..

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

internal_apk: ## Release Apk
	echo "╠ Releasing Apk..."
	bash build-android.sh && flutter build apk --no-tree-shake-icons --dart-define-from-file=.env --flavor internalStaging --target lib/main_internal.dart

internal_appbundle: ## Release Appbundle
	echo "╠ Releasing Appbundle..."
	flutter build appbundle --no-tree-shake-icons --dart-define-from-file=.env --flavor internalProduction --target lib/main_internal.dart

external_apk: ## Release Apk
	echo "╠ Releasing Apk..."
	bash build-android.sh && flutter build apk --no-tree-shake-icons --dart-define-from-file=.env --flavor externalStaging --target lib/main_external.dart

external_appbundle: ## Release Appbundle
	echo "╠ Releasing Appbundle..."
	flutter build appbundle --no-tree-shake-icons --dart-define-from-file=.env --flavor externalProduction --target lib/main_external.dart

internal_adhoc:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to adhoc..."
	bash build-ios.sh && flutter build ipa --dart-define-from-file=.env --flavor internal --target lib/main_internal.dart --export-options-plist=ios/ExportOptions-internal-debug.plist

internal_appstore:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Removing BuildConfig.xcconfig..."
	rm -f ios/Flutter/BuildConfig.xcconfig
	echo "╠ Releasing to app store..."
	flutter build ipa --dart-define-from-file=.env --flavor internal --target lib/main_internal.dart --export-options-plist=ios/ExportOptions-internal-release.plist

external_adhoc:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to adhoc..."
	bash build-ios.sh && flutter build ipa --dart-define-from-file=.env --flavor external --target lib/main_external.dart --export-options-plist=ios/ExportOptions-external-debug.plist

external_appstore:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Removing BuildConfig.xcconfig..."
	rm -f ios/Flutter/BuildConfig.xcconfig
	echo "╠ Releasing to app store..."
	flutter build ipa --dart-define-from-file=.env --flavor external --target lib/main_external.dart --export-options-plist=ios/ExportOptions-external-release.plist
