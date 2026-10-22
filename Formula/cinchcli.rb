class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.11.2/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "0f4c067dbb83d825c437f2e49d0a410bf37bef681b1f4721ecd15f63a73159fb"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.11.2/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a6b03e88fc8130f7c631803777c276384aaee6c2ef877c0da49e31bc0a8c8a07"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.11.2/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "39741e135d002c55beea786a862d266e1b8e750c5ee1bcbe4edd80bb079ca64c"
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
