# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.networkmanager.enable = true;
  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr";
    defaultLocale = "fr_FR.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget

    git
    atom

    firefoxWrapper
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle

    i3status
    dmenu
    i3lock

    chefdk
    vagrant

    gnome3.dconf
    networkmanagerapplet
  ];

  services.xserver.displayManager.sessionCommands = "${pkgs.networkmanagerapplet}/bin/nmapplet &";

  programs.zsh.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # Enable the X11 windowing system
  # services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.enable = true;
  services.xserver.layout = "fr";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  # Enable the KDE Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome3.enable = true;

  services.xserver.windowManager.i3.enable = true;

  # System wide zsh
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.rvlander = {
    isNormalUser = true;
    home = "/home/rvlander";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "storage" "users"];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";


  # Configure synergy
  services.synergy.client.enable = true;
  services.synergy.client.screenName = "TOTO";
  services.synergy.client.serverAddress = "192.168.95.101";

  # sudo
  security.sudo.enable = true;
}
