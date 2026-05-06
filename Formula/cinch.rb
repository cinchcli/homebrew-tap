class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.2"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.2/cinch_Darwin_arm64.tar.gz"
      sha256 "6bbd01a2f519d1480e6c3e991d240bbc66ce20a698b4680543f93d4b97683ab1"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.2/cinch_Linux_arm64.tar.gz"
      sha256 "3aa821126db7a606801b45a27ded5f234076541b1b2f7f05efeb00d9d2fd2d51"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.2/cinch_Linux_x86_64.tar.gz"
      sha256 "3bae3eb1652df2458cdc3be093858e000c892d0c588f1f32232eabf2cb778c70"
    end
  end

  def install
    bin.install "cinch"
  end

  test do
    system "#{bin}/cinch", "--version"
  end
end
