class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.10.1/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "10107b73bc5d171196b451ad337e3abc2a3e2856b305e46e1f280016181ba157"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.10.1/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c430953e8de9e15b216a49951ba79e50c1610b90b834338d572c3df7f9b37b2b"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.10.1/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "83e5cb65fb8fb8d5c7457503c519296f5b62ceb6a8c08946c8f6057cf071459e"
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
