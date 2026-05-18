class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.9"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.9/cinch_Darwin_arm64.tar.gz"
      sha256 "5b1a4512e5e8cfb579cff4e7c865017b8a683e7514e600c5fe9796a2ac94b80b"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.9/cinch_Linux_arm64.tar.gz"
      sha256 "1923bf21746d3b651699fe82060da43f32ddcb9ee2c025adea4bf106a4fef37a"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.9/cinch_Linux_x86_64.tar.gz"
      sha256 "7c1e0111e9f072defd70ba73648b46e061981e9aa9a365474764d59c1d56525d"
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
