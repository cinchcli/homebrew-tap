class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.3.4/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "66a500b69eacfa06e1bc48ade91a072bd583ca7fdf7a5a05b55d20b8ca56d6cd"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.3.4/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "06c3942137a177c5505c79466e2daa7b8fe04329a6622ecbe71522e0dc42316f"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.3.4/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3898ee99baf02ee1f4e63eaa22402e948d7e26c5921461f7668f6b353a762723"
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
