# $ man configuration.nix
# $ nixos-help

{ config, pkgs, lib, ... }:

{
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
		<home-manager/nixos>
	];

	hardware.opengl.extraPackages = with pkgs; [
		intel-compute-runtime
	];
	hardware.bluetooth.enable = true;
	#services.blueman.enable = true;

	#packages

	nixpkgs.config.allowUnfree = true;

	users.users.user = {
		isNormalUser = true;
		extraGroups = [ "wheel" "docker" ];
	};

	home-manager.useGlobalPkgs = true;
	home-manager.users.user = { pkgs, ... }: {
		home.stateVersion = "18.09";
		home.packages = with pkgs; [
			firefox
			kate
			google-chrome
			telegram-desktop
			gnome.cheese
			vscode
			kcalc
			signal-desktop
			git
			gcc
			go
			sqlite
			vlc
			gimp
			ffmpeg
			obs-studio
			spectacle
			kdenlive
			unzip
			stremio
			insomnia
			lsd
			fzf
			zoxide
			retroarchFull
			audacity
			godot
			golangci-lint
			htop
			musescore
			nodejs
			p7zip
			python3
			qbittorrent
			tealdeer
			unrar
			vulkan
		];
	};

	environment.systemPackages = with pkgs; [
		ncdu
		neovim
	];

	programs.zsh = {
		enable = true;
		ohMyZsh = {
			enable = true;
			plugins = [
				"git"
				"colored-man-pages"
				"sudo"
			];
			theme = "robbyrussell";
		};
	};

	environment.systemPackages = with pkgs; [
		ncdu
		neovim
	];

	nix = {
		package = pkgs.nixFlakes;
		extraOptions = "experimental-features = nix-command flakes";
	};

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"steam"
		"steam-original"
		"steam-run"
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Setup keyfile
	boot.initrd.secrets = {
		"/crypto_keyfile.bin" = null;
	};

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "America/Sao_Paulo";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "pt_BR.UTF-8";
		LC_IDENTIFICATION = "pt_BR.UTF-8";
		LC_MEASUREMENT = "pt_BR.UTF-8";
		LC_MONETARY = "pt_BR.UTF-8";
		LC_NAME = "pt_BR.UTF-8";
		LC_NUMERIC = "pt_BR.UTF-8";
		LC_PAPER = "pt_BR.UTF-8";
		LC_TELEPHONE = "pt_BR.UTF-8";
		LC_TIME = "pt_BR.UTF-8";
	};

	# Enable the X11 windowing system.
	services.xserver.enable = true;

	# Enable the KDE Plasma Desktop Environment.
	services.xserver.displayManager.sddm.enable = true;
	services.xserver.desktopManager.plasma5.enable = true;

	# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment this
		#jack.enable = true;

		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	# Some programs need SUID wrappers, can be configured further or are

	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?

}
