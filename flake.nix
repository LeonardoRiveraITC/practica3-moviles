{
description = "Flutter 3.0.4";
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/23.05";
  flake-utils.url = "github:numtide/flake-utils";
};
outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
      };
      buildToolsVersion = "31.0.0";
      androidComposition = pkgs.androidenv.composeAndroidPackages {
      	    includeExtras = [
    	 	 "extras;google;gcm"
    		];
        buildToolsVersions = [ buildToolsVersion ];
        platformVersions = [ "33" ];
        abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
      };
      androidSdk = androidComposition.androidsdk;
      fhs = pkgs.buildFHSUserEnv {
  	name = "gradle-env";
  	targetPkgs = pkgs : (with pkgs;
  	[
	    gradle
	    glibc
	    gradle
	    flutter
	    androidSdk
	    jdk11
	  ]);
};
    in 
{
    devShell=pkgs.mkShell{
    	  GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/31.0.0/aapt2";
    	ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
	name="gradle-env-shell";
	nativeBuildInputs=[fhs];
	shellHook="exec gradle-env";
    };
    
});
}
