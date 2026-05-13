cask "cinch-desktop" do
  version "0.1.3"
  sha256 "6ad461e5802e1c5c204c7ab55aebc6f6422c6e9372b288dc89bf3d4014539772"

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
