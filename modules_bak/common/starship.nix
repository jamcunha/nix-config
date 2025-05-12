{ config, lib, ... }:

{
  options.starship.enable = lib.mkEnableOption {
    description = "Enable starship prompt";
    default = false;
  };

  config = lib.mkIf config.starship.enable {
    home-manager.users.${config.user} = {
      # programs.starship =
      #   let
      #     promptOrder = [
      #       "character"
      #       "directory"
      #       "git_branch"
      #       "git_status"
      #       "nix_shell"
      #     ];
      #
      #     promptFormat = lib.concatStrings (map (s: "\$${s}") promptOrder);
      #   in
      #   {
      #     enable = true;
      #
      #     settings = {
      #       add_newline = false;
      #
      #       format = promptFormat;
      #
      #       character = {
      #         success_symbol = "[➜](bold green) ";
      #         error_symbol = "[➜](bold red) ";
      #       };
      #
      #       git_branch = {
      #         format = "[git:\\([$branch](bold red)\\)]($style) ";
      #         style = "bold blue";
      #       };
      #     };
      #   };

      programs.starship = {
        enable = true;

        settings = {
          add_newline = false;

          aws = {
            symbol = "  ";
          };

          buf = {
            symbol = " ";
          };

          c = {
            symbol = " ";
          };

          conda = {
            symbol = " ";
          };

          crystal = {
            symbol = " ";
          };

          dart = {
            symbol = " ";
          };

          directory = {
            read_only = " 󰌾";
          };

          docker_context = {
            symbol = " ";
          };

          elixir = {
            symbol = " ";
          };

          elm = {
            symbol = " ";
          };

          fennel = {
            symbol = " ";
          };

          fossil_branch = {
            symbol = " ";
          };

          git_branch = {
            symbol = " ";
          };

          golang = {
            symbol = " ";
          };

          guix_shell = {
            symbol = " ";
          };

          haskell = {
            symbol = " ";
          };

          haxe = {
            symbol = " ";
          };

          hg_branch = {
            symbol = " ";
          };

          hostname = {
            ssh_symbol = " ";
          };

          java = {
            symbol = " ";
          };

          julia = {
            symbol = " ";
          };

          kotlin = {
            symbol = " ";
          };

          lua = {
            symbol = " ";
          };

          memory_usage = {
            symbol = "󰍛 ";
          };

          meson = {
            symbol = "󰔷 ";
          };

          nim = {
            symbol = "󰆥 ";
          };

          nix_shell = {
            symbol = " ";
          };

          nodejs = {
            symbol = " ";
          };

          ocaml = {
            symbol = " ";
          };

          os.symbols = {
            Alpaquita = " ";
            Alpine = " ";
            AlmaLinux = " ";
            Amazon = " ";
            Android = " ";
            Arch = " ";
            Artix = " ";
            CentOS = " ";
            Debian = " ";
            DragonFly = " ";
            Emscripten = " ";
            EndeavourOS = " ";
            Fedora = " ";
            FreeBSD = " ";
            Garuda = "󰛓 ";
            Gentoo = " ";
            HardenedBSD = "󰞌 ";
            Illumos = "󰈸 ";
            Kali = " ";
            Linux = " ";
            Mabox = " ";
            Macos = " ";
            Manjaro = " ";
            Mariner = " ";
            MidnightBSD = " ";
            Mint = " ";
            NetBSD = " ";
            NixOS = " ";
            OpenBSD = "󰈺 ";
            openSUSE = " ";
            OracleLinux = "󰌷 ";
            Pop = " ";
            Raspbian = " ";
            Redhat = " ";
            RedHatEnterprise = " ";
            RockyLinux = " ";
            Redox = "󰀘 ";
            Solus = "󰠳 ";
            SUSE = " ";
            Ubuntu = " ";
            Unknown = " ";
            Void = " ";
            Windows = "󰍲 ";
          };

          package = {
            symbol = "󰏗 ";
          };

          perl = {
            symbol = " ";
          };

          php = {
            symbol = " ";
          };

          pijul_channel = {
            symbol = " ";
          };

          python = {
            symbol = " ";
          };

          rlang = {
            symbol = "󰟔 ";
          };

          ruby = {
            symbol = " ";
          };

          rust = {
            symbol = "󱘗 ";
          };

          scala = {
            symbol = " ";
          };

          swift = {
            symbol = " ";
          };

          zig = {
            symbol = " ";
          };
        };
      };
    };
  };
}
