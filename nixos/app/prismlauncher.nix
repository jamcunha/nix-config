{pkgs, ...}: {
  # Should this be in home manager?

  environment.systemPackages = [pkgs.prismlauncher];

  # If needed:
  # environment.systemPackages = [(pkgs.prismlauncher.override {
  #   jdks = [
  #     temurin-bin-8
  #     temurin-bin-17
  #     temurin-bin-21
  #   ];
  # })];
}
