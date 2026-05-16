class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.7"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.7/cinch_Darwin_arm64.tar.gz"
      sha256 "19f4255ad3e48105ff6b090243d65e07adda2d9d5a2bd62dd5132c561b182bf1"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.7/cinch_Linux_arm64.tar.gz"
      sha256 "62db8be803a1493c5ec0908b70c774a20f2229aeb755d8553670abbb517a26ce"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.7/cinch_Linux_x86_64.tar.gz"
      sha256 "385a433cb4fbb7e20e1fdb0c938c8dc852b4ddc1d4e72b706c43510884c75789"
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
