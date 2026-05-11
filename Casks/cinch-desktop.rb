cask "cinch-desktop" do
  version "0.1.2"
  sha256 "b5bf3d5ca112bcbcb4c5bcf53a7eeb26e7948e4ff58014d1581b5722cc2e40bc"

  url "https://github.com/cinchcli/desktop/releases/download/desktop-v#{version}/Cinch_#{version}_aarch64.dmg",
      verified: "github.com/cinchcli/desktop/"
  name "Cinch"
  desc "Remote clipboard desktop app"
  homepage "https://cinchcli.com/"

  depends_on formula: "cinch"
  depends_on macos: ">= :big_sur"
  depends_on arch: :arm64

  app "Cinch.app"

  zap trash: [
    "~/Library/Application Support/me.jinmu.cinch",
    "~/Library/Caches/me.jinmu.cinch",
    "~/Library/Preferences/me.jinmu.cinch.plist",
  ]
end
