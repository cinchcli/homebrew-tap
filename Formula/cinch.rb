class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.3.2/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "abb06b8b443512ba17e1bc9f654b9d8d809e9a00fe6d23455664badbdb5c01d2"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.3.2/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ee15e9d2766fb0617d2af65016b8476ac4d96553a804a8fba53598b11ac706e"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.3.2/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "10c5de4290d89196cc3936bee3d4c3bbac91b89ebd84da00838c765166d14c66"
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
