class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.3.1"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.3.1/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "7c7d0b21e5117e23409ba9fbb8668c1e542a7e9c941728e5dae49a154446a9c5"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.3.1/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "df7f95145a5377c0b13680e11e1f9b88cd188548fe3d029160b67c401e12ec0e"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.3.1/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "469c3e4044636745f347f69eec01cdc73bb79ee316a6ffe3180c63fbf67088f4"
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
