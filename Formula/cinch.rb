class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.4"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.4/cinch_Darwin_arm64.tar.gz"
      sha256 "21a4b07f5456452cc56208b92498d019635c391048aff3afe58cee874311b8a3"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.4/cinch_Linux_arm64.tar.gz"
      sha256 "eb7ebb4c5c4ee7943d3bdf9127be1728f05f4c0e08921e9eef21c77aaf5135ce"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.4/cinch_Linux_x86_64.tar.gz"
      sha256 "d6ab421fc09eb88e8e613ecb1be325c1acead1a60211b2d7c24c6626f9995185"
    end
  end

  def install
    bin.install "cinch"
    generate_completions_from_executable(bin/"cinch", "completion",
                                         shells: [:bash, :zsh, :fish])
  end

  test do
    system "#{bin}/cinch", "--version"
  end
end
