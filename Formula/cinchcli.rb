class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.4.0/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "ed4c38b942bf9b0a5eca3f692838af52a8cf0a91d6c86473a4097f9ce65e68a2"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.4.0/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cb8471a7f8d70d05f95f22a73c0a3a659a076d82edf0df6fd230c2c337467b1c"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.4.0/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "266c5151d76afa7ab354c5046a126b3b5da194bb844179530004e28e41b768e2"
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
