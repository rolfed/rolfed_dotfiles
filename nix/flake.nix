{
  description = "Rolfe Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
          # wezterm - current issue https://github.com/wez/wezterm/issues/5990
          bat
          cargo
          direnv
          eza
          fzf
          git
          neovim
          nixd
          obsidian
          raycast
          starship
          stow
          tmux
          tmuxinator
          zoxide
      ]; 

      nix.nixPath = [ "nixpkg=${inputs.nixpkgs}" ];

      homebrew = {
        enable = true;
        casks = [
          "brave-browser"
          "hammerspoon" # ref https://www.hammerspoon.org/
          "iina"
          "atuin"
          "wezterm" # temp reference current issue above
        ];

        # Not supported for my mac
        # brews = [
        #   "mas"
        # ];
        # masApps = {
        #   "1Password" = 1333542190;
        #   "Yoink" = 457622435;
        # };
        onActivation.cleanup = "zap";

        # On Nix update, update brew as well
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      }; 

      fonts.packages = with pkgs; [
          (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';

      # MacOs System defaults
      system.defaults = {
        dock.autohide = true;
        dock.show-recents = false;
        dock.persistent-apps = [
            "${pkgs.obsidian}/Applications/Obsidian.app"
            "/Applications/Brave\ Browser.app/"
            "/Applications/WezTerm.app"
        ];
        loginwindow.GuestEnabled = false;
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Danniels-Mac-Pro
    darwinConfigurations."Danniels-Mac-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = { 
              enable = true; 
              # Apple Silicon Only
              # enableRosetta = true
              user = "dannielrolfe";
              # Automatically migrate existing Homebrew installations
              autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Danniels-Mac-Pro".pkgs;
  };
}

