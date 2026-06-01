class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.5.0/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "64c58306f45fe7b0763ccc8d2a3699d803b82ff92ed3a958a04b2ae52002f6f6"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.5.0/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "06c4a5f5ab518ed2ca9546798a2954e2c8a7f3d95f4ab6d1f6396430213366a0"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.5.0/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "017347cce428a1f38fbb135688a4bb1aac8452cd45fe1904b414fde7efb9b15c"
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
