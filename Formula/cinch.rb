class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.2.0"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.2.0/cinch_Darwin_arm64.tar.gz"
      sha256 "83ad966f9fe87cc0fdf9c366b33f68e1bb7a179c56f2afd80ee150ce8503591c"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.2.0/cinch_Linux_arm64.tar.gz"
      sha256 "579db3d5b8cdc851f31e008ad21bfa552437eed4eaa9de6fa98b379fd05f289c"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.2.0/cinch_Linux_x86_64.tar.gz"
      sha256 "57fd443f8c6e68ef87e9af5674640ea90751fc7ff0eee8e7c14b68c1683863e1"
    end
  end

  def install
    bin.install "cinch"
    generate_completions_from_executable(bin/"cinch", "completion",
                                         shells: [:bash, :zsh, :fish])
  end

  test do
    system "#{bin}/cinch", "--version"
  end
end
