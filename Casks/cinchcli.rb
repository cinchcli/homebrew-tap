cask "cinchcli" do
  version "0.4.2"
  sha256 "a5fbe53631cd91a884f959394d127cc47e0e80bd583fc8f01fb3f549f1769763"

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
