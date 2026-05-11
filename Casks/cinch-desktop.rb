cask "cinch-desktop" do
  arch arm: "aarch64", intel: "84ea05e4637a533783d6124e6c7859265e32ab95ea75cb2741c5b571a1eb78ee"

  version "0.1.2"
  sha256 arm:   "b5bf3d5ca112bcbcb4c5bcf53a7eeb26e7948e4ff58014d1581b5722cc2e40bc",
         intel: "84ea05e4637a533783d6124e6c7859265e32ab95ea75cb2741c5b571a1eb78ee"

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
