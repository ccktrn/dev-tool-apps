# makefile
.PHONY : list
list : # show this list
# 行頭の".PHONY"を検索 => ".PHONY"を削除 => 空白区切りを改行 => 全要素に対して" -e ^"をつける(grepの行頭検索) 
	@echo "---- list of available commands ---"
	@grep $$(grep '^\.PHONY' makefile | sed -e "s/\.PHONY *: *//g" | sed -e "s/ \+/\n/g" |  xargs -I@ echo " -e ^@") makefile
###---

## build-release ##
.PHONY: build-web build-apk build-aab build-ios

build-web: # for webserver
	flutter build web
build-apk: # Android apk file
	flutter build apk
build-aab: # AndroidAppBundle (for PlayStore)
	flutter build appbundle
build-ipa: # IOS ipa file
	flutter build ios

## adb-wireless-debug (android device buildtool) ##
.PHONY: adb-connect adb-install
adb_host = 192.168.40.13
adb_port = 45005 # 変わる

adb-connect: 
	adb connect ${adb_host}:${adb_port}
adb-install:
	adb install ./build/app/outputs/flutter-apk/app-release.apk


## resource-genarate ##
.PHONY: watch gen-code gen-icon

watch: #start watching and auto-build
	flutter pub run build_runner watch

gen-code: # auto-gen code by build-runner
	flutter pub run build_runner build
gen-icon: # icon resource for Native
	flutter pub run flutter_launcher_icons:main



