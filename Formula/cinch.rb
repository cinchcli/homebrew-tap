class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.5"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.5/cinch_Darwin_arm64.tar.gz"
      sha256 "456630a26a08247ef72c5d3eb5fb3c036c1cfa174764293374290a4302584347"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.5/cinch_Linux_arm64.tar.gz"
      sha256 "d85d1f2b59962f95b6bdf0b08ad84ea250fcf08fc27963a2d5a193f9d58dc097"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.5/cinch_Linux_x86_64.tar.gz"
      sha256 "b76b1756f0541b35c99ec65998d7f5276b53ca8bfa7cebbd384dff750fe6cd53"
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
