class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.8"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.8/cinch_Darwin_arm64.tar.gz"
      sha256 "0080280fab1569dcf6a9760c4f465e144dc5c33fdf1c950c24dfa4e414a1c90f"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.8/cinch_Linux_arm64.tar.gz"
      sha256 "75406cc43b0f2d3f4805a4e8318303b37780958cc8db618b74b009c2fa0ce8d9"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.8/cinch_Linux_x86_64.tar.gz"
      sha256 "5ca97e0415129fd20c6a7917c2a5f92a02651045e00976b5e08f7d5a9e42aa2c"
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
