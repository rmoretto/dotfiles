{
  self,
  ...
}: {
  flake.modules.homeManager.rmoretto-llm = {
    pkgs,
    config,
    ...
  }: let
    deep-code-gen = conf:
      pkgs.writeShellApplication {
        name = "deepcode-${conf.model}";
        runtimeInputs = with pkgs; [unstable.claude-code];
        text = ''
          #! /usr/bin/env bash
          set -euo pipefail

          ANTHROPIC_AUTH_TOKEN=$(cat ${conf.deepApiKeyPath})

          export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
          export ANTHROPIC_AUTH_TOKEN
          export ANTHROPIC_MODEL=deepseek-${conf.model}
          export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1

          exec claude "$@"
        '';
      };
  in {
    imports = [
      self.modules.homeManager.rmoretto-sops
    ];

    sops = {
      secrets."llm/deepseek_api_key" = {};
      templates."deepseek-api-key" = {
        content = "${config.sops.placeholder."llm/deepseek_api_key"}";
      };
    };

    home.packages = [
      (deep-code-gen
        {
          deepApiKeyPath = config.sops.templates."deepseek-api-key".path;
          model = "v4-pro";
        })

      (deep-code-gen
        {
          deepApiKeyPath = config.sops.templates."deepseek-api-key".path;
          model = "v4-flash";
        })
    ];
  };

  flake.modules.nixos.rmoretto-llm = {
    home-manager.sharedModules = [
      self.modules.homeManager.rmoretto-llm
    ];
  };
}
