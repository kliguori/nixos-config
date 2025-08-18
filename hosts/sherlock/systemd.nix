{ config, lib, pkgs, ... }:

{
  systemd = {
    # Set directory/file permissions and create symlinks
    tmpfiles.rules = [
      # Permissions for bind mounted directories (also creates directories if they don't exist)
      # "d /persist/etc/NetworkManager/system-connections 0700 root root - -" # NetworkManager connections
    
      # Permissions for symlinked files (also creates file and parent directories if they don't exist)
      # "f /persist/home/admin/.gitconfig 0644 admin users - -" # Git configuration

      # Symlink persistent files
      # "L+ /home/admin/.gitconfig - - - - /persist/home/admin/.gitconfig" # Symlink .gitconfig
    ];
  };
}