class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.6.0/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "3f49a1a25a9e5a22e2088719957c98a5ffcdf08d42de023780d6748f5921fe23"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.6.0/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "39df6c05c5b8703f449e1f67eb1547a15f8f70ef29529ab7bca45bbb9d8f26a1"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.6.0/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c7d667a8b2879b460368b668f9ffa3befa113331b6ccd0505f5cf7c027f1e974"
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
