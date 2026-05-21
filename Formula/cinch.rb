class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.2.1"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.2.1/cinch_Darwin_arm64.tar.gz"
      sha256 "b1e7e7daa2c2bdf91dadf4828d7e62b060ffa537272736bd29645625abe08f96"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.2.1/cinch_Linux_arm64.tar.gz"
      sha256 "b9893bfa605d11191f6e9d1ca3006bc057f560d618e47f2eb81b8d880acd458b"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.2.1/cinch_Linux_x86_64.tar.gz"
      sha256 "154e7c3d14c62fbd11837d8b2b5cf04216e38681d5f563d0a38635c403a70730"
    end
  end

  conflicts_with cask:    "cinch",
                 because: "the cask provides a `cinch` symlink via the desktop app's embedded CLI"

  def install
    bin.install "cinch"
    generate_completions_from_executable(bin/"cinch", "completion",
                                         shells: [:bash, :zsh, :fish])
  end

  test do
    system bin/"cinch", "--version"
  end
end
