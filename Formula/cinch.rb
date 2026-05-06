class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.3"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.3/cinch_Darwin_arm64.tar.gz"
      sha256 "816d22a1cfcb7fa01552c785400925dd4401130c0cf50df0ecdb63289793781f"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.3/cinch_Linux_arm64.tar.gz"
      sha256 "cb25873d8f9bdc8f5dabbc2001d94fc9013a5926c1f21655b3839beba12a8973"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.3/cinch_Linux_x86_64.tar.gz"
      sha256 "da8f89ad2260b5e6ee1cff4f2de87652ab69ddb4bbf390ebfede123d446c0809"
    end
  end

  def install
    bin.install "cinch"
  end

  test do
    system "#{bin}/cinch", "--version"
  end
end
