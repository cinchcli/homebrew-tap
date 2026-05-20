cask "cinch-desktop" do
  version "0.1.12"
  sha256 "a8bbb83a535f10ab899cc7613563a0e390c7299305e8eecf4820f9cabc62a05c"

  url "https://github.com/cinchcli/desktop/releases/download/desktop-v#{version}/Cinch_#{version}_aarch64.dmg",
      verified: "github.com/cinchcli/desktop/"
  name "Cinch"
  desc "Remote clipboard desktop app"
  homepage "https://cinchcli.com/"

  depends_on formula: "cinch"
  depends_on macos: :big_sur
  depends_on arch: :arm64

  app "Cinch.app"

  zap trash: [
    "~/Library/Application Support/me.jinmu.cinch",
    "~/Library/Caches/me.jinmu.cinch",
    "~/Library/Preferences/me.jinmu.cinch.plist",
  ]
end
