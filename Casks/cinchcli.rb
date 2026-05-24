cask "cinchcli" do
  version "0.3.4"
  sha256 "541eaf1e033927f93981348370058e582b40cedb5dcd9c0f01db6c3a544f025b"

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
