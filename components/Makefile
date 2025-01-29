# makefile
.DEFAULT_GOAL := help
.PHONY: help
help:	## コマンド一覧表示
	@grep -E '^[[:alnum:]_/-]+ *:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


## build-release ##
.PHONY: build-web build-apk build-aab build-ios

build-web: ## webserver 
	flutter build web
build-apk: ## Android apk file
	flutter build apk
build-aab: ## Android App Bundle
	flutter build appbundle
build-ipa: ## IOS ipa file
	flutter build ios

## adb-wireless-debug (android device buildtool) ##
.PHONY: install-apk

install-apk: ## install to connected device
	adb install ./build/app/outputs/flutter-apk/app-release.apk


# ## resource-genarate ##
# .PHONY: watch gen-code gen-icon

# watch: ## start watching and auto-build
# 	flutter pub run build_runner watch

# gen-code: ## auto-gen code by build-runner
# 	flutter pub run build_runner build
# gen-icon: ## icon resource for Native
# 	flutter pub run flutter_launcher_icons:main



