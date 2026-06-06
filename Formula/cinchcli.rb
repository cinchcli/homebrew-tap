class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.7.0/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "5d0e222676408606ee8de292a84687ca2ea3ef0285a4de77a571da3aa8519804"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.7.0/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e9a737c165dad214db8e1aa88e956d6a5dd8d56ecf8d8720d7374bb5d47ac28c"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.7.0/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "859ea0756729ed7dc3d7f958a31a22ca86a0f296be5da9fb498f08ca1fd6e01c"
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
