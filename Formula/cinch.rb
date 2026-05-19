class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.10"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.10/cinch_Darwin_arm64.tar.gz"
      sha256 "9d7c8518d66644e802070d5a55cba25bca55429dab8527343137472124471bcc"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.10/cinch_Linux_arm64.tar.gz"
      sha256 "2fc08e9a8fbdf8f55cb925403a319e052ac86a8abb60739e9881fa1c6179c1e9"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.10/cinch_Linux_x86_64.tar.gz"
      sha256 "4cd3f0028ab49d8e4d1619a46bae3c8b865b1dcc80326b9f57e740a16cafe2ce"
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
