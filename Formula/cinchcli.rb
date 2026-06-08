class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.7.1/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "f2d9468ba5febee43be331ce37b0f0d90045df73426facc10509a9bd76c30a18"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.7.1/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6acc6c2d79e2d164494f38503064a1e7c7c9b59e245103b7f8f7dd8feb741503"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.7.1/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4cd4201f2499a6537fee9ff9a868d875fc8dbee4e60ae3d4224586b14abc919f"
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
