class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.8.0/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "ff1c3ba9591bdc7749358218dde8bd1b31cd21ff9a4ab430dd93e6358a4e3449"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.8.0/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "81a66604040d0251e5562c7fb3fff6572164ac8b1c8dc7edd66a93fd6e6ef704"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.8.0/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f70c3ad171b7cd7f69686e01546b6df4498e76160ad68907cb6d0a3052993471"
    end
  end

  conflicts_with cask:    "cinchcli",
                 because: "the cask provides a `cinch` symlink via the desktop app's embedded CLI"

  def install
    bin.install "cinch"
    generate_completions_from_executable(bin/"cinch", "completion",
                                         shells: [:bash, :zsh, :fish])

    # `ci` is a short alias for `cinch`. Re-create our own `ci` (it resolves
    # into this formula's Cellar) so the alias survives `brew upgrade` — the
    # old version's `ci` is still linked while this install runs, so a plain
    # `File.exist?` guard would skip it and the alias would vanish. Skip only
    # when a *foreign* `ci` owns the slot (e.g. another formula), so we never
    # block `brew link` and leave cinch itself unlinked.
    ci_link = Pathname.new("#{HOMEBREW_PREFIX}/bin/ci")
    cinchcli_cellar = Pathname.new(HOMEBREW_CELLAR)/"cinchcli"
    ci_is_ours = ci_link.exist? && cinchcli_cellar.exist? &&
                 ci_link.realpath.to_s.start_with?("#{cinchcli_cellar.realpath}/")
    if !ci_link.exist? || ci_is_ours
      bin.install_symlink "cinch" => "ci"
      generate_completions_from_executable(bin/"ci", "completion",
                                         shells:    [:bash, :zsh, :fish],
                                         base_name: "ci")
    end
  end

  test do
    system bin/"cinch", "--version"
    system bin/"ci", "--version" if (bin/"ci").exist?
  end
end
