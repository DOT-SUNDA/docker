# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.chromium
    pkgs.procps
    pkgs.htop
    pkgs.cloudflared
    pkgs.jq
    pkgs.curl
  ];
  
  # Mengaktifkan layanan Docker di dalam IDX
  services.docker.enable = true;

  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
    ];
    # Enable previews
    previews = {
      enable = true;
      previews = {};
    };
    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ ".idx/dev.nix" ];
      };
      # Runs when the workspace is (re)started
      onStart = {
        init-system = "git stash && git pull";
        # Menjalankan logika docker langsung di sini tanpa file .sh tambahan
        # Menggunakan format '' untuk multi-line string agar aman dari syntax error
      };
    };
  };
}
