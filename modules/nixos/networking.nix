{ ... }:
{
  networking = {
    hostName = "rodrigo-pc";
    # networkmanager.enable = true;
  };

  systemd.network = {
    enable = true;
    
    netdevs."25-br0" = {
      netdevConfig = {
        Name = "br0";
        Kind = "bridge";
      };
    };

    networks."25-br0-network" = {
      matchConfig.Name = ["eno1" "vm-*"];
      networkConfig = {
        Bridge = "br0";
      };
    };

    networks."25-br0" = {
      matchConfig.Name = "br0";
      linkConfig = {
        RequiredForOnline = "routable";
      };

      networkConfig = {
        DHCP = "yes";
        IPv6AcceptRA = true;
      };
    };
  };
}
