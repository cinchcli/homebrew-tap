class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local"
  homepage "https://cinchcli.com"
  version "0.1.11"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.11/cinch_Darwin_arm64.tar.gz"
      sha256 "76751f63d8534a600bdbd64f9b25494cc32228f6674ea6c6fa5619cfdc2e9ae7"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.11/cinch_Linux_arm64.tar.gz"
      sha256 "48df48e4961229b01d9c6ec824090170965d9644d39915aa44729f7fa9484999"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.11/cinch_Linux_x86_64.tar.gz"
      sha256 "cb57016f340a0bf01a204f64723fb6121d351131858bb471beba7fd68ee37248"
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
