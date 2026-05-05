class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local."
  homepage "https://cinchcli.com"
  version "0.1.0"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.0/cinch_Darwin_arm64.tar.gz"
      sha256 "899ddaddfddc91733393ad3f9289ffd220ca858635766faa528f0d48a9df74d5"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.0/cinch_Linux_arm64.tar.gz"
      sha256 "d39c3e7da919451e069853032855a7c9c6872d59d70eaf4ce0cce0df175e10e5"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.0/cinch_Linux_x86_64.tar.gz"
      sha256 "476a1a40175ea9284d9df7f3d10b6c114c6f6c850356c229e166e973f259dc67"
    end
  end

  def install
    bin.install "cinch"
  end

  test do
    system "#{bin}/cinch", "--version"
  end
end
