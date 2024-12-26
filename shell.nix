{ pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  }
}:

let
  android = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ "30.0.3" "33.0.2" "34.0.0" ];
    platformVersions = [ "34" ];
    abiVersions = [ "x86" "x86_64" ];
    # https://github.com/NixOS/nixpkgs/issues/267263#issuecomment-1833769682
    extraLicenses = [
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "android-sdk-license"
      "android-sdk-preview-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
    ];
  };
in
pkgs.mkShell rec {
  buildInputs = with pkgs; [
    # https://github.com/NixOS/nixpkgs/issues/341147#issuecomment-2359171650
    vulkan-loader
    libGL
    pkg-config
    gtk3
    pcre2.dev
    util-linux.dev
    libselinux
    libsepol
    libthai
    libdatrie
    xorg.libXdmcp
    xorg.libXtst
    lerc.dev
    libxkbcommon
    libepoxy

    # https://nixos.wiki/wiki/Flutter
    flutter
    android.androidsdk
    android.platform-tools
    jdk17
  ];

  ANDROID_HOME = "${android.androidsdk}/libexec/android-sdk";
  GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${android.androidsdk}/libexec/android-sdk/build-tools/33.0.2/aapt2";
}
