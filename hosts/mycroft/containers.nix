{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation = {
    podman.enable = true;
    oci-containers = {
      backend = "podman";

      containers.uptime-kuma = {
        image = "louislam/uptime-kuma:latest";
        autoStart = true;
        ports = [ "3001:3001" ];
        volumes = [
          "/persist/containers/uptime-kuma:/app/data"
        ];
      };
    };
  };

  # Make Podman’s own storage persistent (so images survive an ephemeral /)
  environment.etc."containers/storage.conf".text = ''
    [storage]
    driver = "overlay"
    graphroot = "/persist/containers/storage"
    runroot  = "/persist/containers/runroot"
  '';

}
