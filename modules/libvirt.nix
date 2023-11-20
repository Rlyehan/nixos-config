{
  lib,
  pkgs,
  ...
}: {

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.runAsRoot = true;
    };
  };
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    # Need to add [File (in the menu bar) -> Add connection] when start for the first time
    virt-manager

    # QEMU/KVM, provides:
    #   qemu-storage-daemon qemu-edid qemu-ga
    #   qemu-pr-helper qemu-nbd elf2dmp qemu-img qemu-io
    #   qemu-kvm qemu-system-x86_64 qemu-system-aarch64 qemu-system-i386
    qemu_kvm
    qemu_full
  ];

  boot.kernelModules = ["kvm-amd"];
  # Enable nested virsualization, required by security containers and nested vm.
  boot.extraModprobeConfig = "options kvm_amd nested=1";  # for amd cpu
}
