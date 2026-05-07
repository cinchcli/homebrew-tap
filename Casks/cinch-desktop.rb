cask "cinch-desktop" do
  arch arm: "aarch64", intel: "d5f0c2a33770421a2e8da92cced3177e11080258c8b3c0e49e9f71ba7d802879"

  version "0.1.1"
  sha256 arm:   "eb60c4ddebd37011b33e20a80a1af9093647cbdab85a9def5cb43338856c2d6b",
         intel: "d5f0c2a33770421a2e8da92cced3177e11080258c8b3c0e49e9f71ba7d802879"

  url "https://github.com/cinchcli/desktop/releases/download/desktop-v#{version}/Cinch_#{version}_#{arch}.dmg",
      verified: "github.com/cinchcli/desktop/"
  name "Cinch"
  desc "Remote clipboard desktop app"
  homepage "https://cinchcli.com/"

  depends_on formula: "cinch"
  depends_on macos: ">= :big_sur"

  app "Cinch.app"

  zap trash: [
    "~/Library/Application Support/me.jinmu.cinch",
    "~/Library/Caches/me.jinmu.cinch",
    "~/Library/Preferences/me.jinmu.cinch.plist",
  ]
end
