class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.4.2/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "384ae74b22772f9d2a2a5e9b6db47ac824d2eed14496ba17ac5aaab12e745c48"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.4.2/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ffb08fd484e4d39f2cfe8e5418470a2357b5ddd676f7af25302858dbc2b44cd9"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.4.2/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9bab155589a6b0d9a821e6b06c289bd90efa65656b313b3d0e26c82a9199cb00"
    end
  end

  conflicts_with cask:    "cinchcli",
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
