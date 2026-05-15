class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.6"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.6/cinch_Darwin_arm64.tar.gz"
      sha256 "5ba719b01f775b260c5296e37ccb302dea389adb21d5194ba34f8fb886ff127f"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.6/cinch_Linux_arm64.tar.gz"
      sha256 "43057d21e75166e3a1fecd9800c1cfbe577be537cd7696c70e88e2e32bb47261"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.6/cinch_Linux_x86_64.tar.gz"
      sha256 "296ab3a0afa4505325b5f7ef91a8c7744c997c6b036c1774e2a3cfda01a0072b"
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
