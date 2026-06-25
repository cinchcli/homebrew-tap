class Cinchcli < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  license "AGPL-3.0"
  # `version` is intentionally omitted — Homebrew parses it from the
  # `release/<X.Y.Z>/` path segment in `url`. `brew audit` errors with
  # "version X is redundant with version scanned from URL" if both are set.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.11.1/cinch-cli-aarch64-apple-darwin.tar.gz"
      sha256 "0299bf99eea4293610e280cedf3754333ab8f546f708d5203bd7b7354e35df1f"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/release/0.11.1/cinch-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aad32efe5e2de5bc9b291ac5ca5d5d8daeddd155cc471c5b13e73f32bdcdd1c9"
    else
      url "https://github.com/cinchcli/cinch/releases/download/release/0.11.1/cinch-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0696a46c2b7ab7addbca168d60bf0c5c04773c8fcdc0703d176358c95fa70521"
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
