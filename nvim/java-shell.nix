{
  description = "Java Development Environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = inputs: let
    javaVersion = 17; # Change this value to update the whole stack

    supportedSystems = ["x86_64-linux" "aarch64-linux"];
    forEachSupportedSystem = f:
      inputs.nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [inputs.self.overlays.default];
          };
        });
  in {
    overlays.default = final: prev: let
      jdk = prev."jdk${toString javaVersion}";
    in {
      inherit jdk;
      maven = prev.maven.override {jdk_headless = jdk;};
      gradle = prev.gradle.override {java = jdk;};
      lombok = prev.lombok.override {inherit jdk;};
    };

    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          gcc
          gradle
          jdk
          maven
          ncurses
          patchelf
          zlib
          jdt-language-server
        ];

        shellHook = let
          loadLombok = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
          prev = "\${JAVA_TOOL_OPTIONS:+ $JAVA_TOOL_OPTIONS}";
        in ''
          export JAVA_TOOL_OPTIONS="${loadLombok}${prev}"
        '';
      };
    });
  };
}
