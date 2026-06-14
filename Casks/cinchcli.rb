cask "cinchcli" do
  version "0.9.0"
  sha256 "66fd91d04a2c65a33018c7d3b012b5de832800f57c6181e23d815cbe34ce1d68"

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
  # `ci` short alias — same embedded CLI binary, dispatched on argv[0].
  binary "#{appdir}/Cinch.app/Contents/MacOS/Cinch", target: "ci"

  zap trash: [
    "~/Library/Application Support/me.jinmu.cinch",
    "~/Library/Caches/me.jinmu.cinch",
    "~/Library/Preferences/me.jinmu.cinch.plist",
    "~/Library/Saved Application State/me.jinmu.cinch.savedState",
  ]
end
