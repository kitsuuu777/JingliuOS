{ ... }:

{
  services.pipewire.extraConfig.pipewire-pulse."vesktop-mic-fix" = {
    "pulse.rules" = [
      {
        matches = [
          { "application.name" = "vesktop"; }
        ];

        actions = {
          quirks = [
            "block-source-volume"
          ];
        };
      }
    ];
  };

  services.pipewire.wireplumber.extraConfig."20-mic-volume" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          {
            "node.name" = "alsa_input.pci-0000_06_00.6.analog-stereo";
          }
        ];

        actions = {
          "update-props" = {
            "device.routes.default-source-volume" = 0.38;
          };
        };
      }
    ];
  };

  hardware.alsa.enablePersistence = true;
}
