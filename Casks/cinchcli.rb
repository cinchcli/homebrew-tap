cask "cinchcli" do
  version "0.7.1"
  sha256 "40713eed7c3ac1788189717c8f2e9bc97f01a6d4a3bb6b1a1cb70541f2c8700b"

  url "https://github.com/cinchcli/cinch/releases/download/release/#{version}/Cinch_#{version}_aarch64.dmg",
      verified: "github.com/cinchcli/cinch/"
  name "Cinch"
  desc "Multi-server clipboard sync - desktop app with embedded CLI"
  homepage "https://cinchcli.com/"

  depends_on macos: :big_sur
  depends_on arch: :arm64

  app "Cinch.app"
  # Bundle the embedded CLI as /opt/homebrew/bin/cinch via Cask's `target:`
  # rename. Same physical binary as the desktop .app; dispatch on argv[0]
  # basename - see apps/desktop/CLAUDE.md "CLI Embedding" in cinchcli/cinch.
  binary "#{appdir}/Cinch.app/Contents/MacOS/Cinch", target: "cinch"

  zap trash: [
    "~/Library/Application Support/me.jinmu.cinch",
    "~/Library/Caches/me.jinmu.cinch",
    "~/Library/Preferences/me.jinmu.cinch.plist",
    "~/Library/Saved Application State/me.jinmu.cinch.savedState",
  ]
end
