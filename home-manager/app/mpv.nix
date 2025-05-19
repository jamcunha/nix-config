{...}: {
  programs.mpv = {
    enable = true;

    config = {
      gpu-api = "vulkan";
      hwdec = "auto-safe";
      vo = "gpu-next";
      # hr-seek = "yes";

      keep-open = "yes";
    };

    profiles = {
      "protocol.http" = {
        hls-bitrate = "max";
        cache = "yes";
        no-cache-pause = true;
      };
    };

    bindings = {
      RIGHT = "no-osd seek 5 exact";
      LEFT = "no-osd seek -5 exact";
      UP = "add volume 5";
      DOWN = "add volume -5";
    };
  };
}
