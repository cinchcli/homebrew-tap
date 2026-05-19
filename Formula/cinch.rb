class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.12"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.12/cinch_Darwin_arm64.tar.gz"
      sha256 "38843548c33cab5fd9826ab711f14c34f9c8682323414e197e622fef067c0715"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.12/cinch_Linux_arm64.tar.gz"
      sha256 "0d7890b26cbb1a1a68b08332fe14a052bb328f9861de3e9d3cace33ee7c11e92"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.12/cinch_Linux_x86_64.tar.gz"
      sha256 "8f3be194ce8f6ccee43c17ef10b2b51cedadd67281428b00505685e9d6f76946"
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
