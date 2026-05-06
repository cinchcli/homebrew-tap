class Cinch < Formula
  desc "Remote clipboard tool. Push from SSH, pull to local."
  homepage "https://cinchcli.com"
  version "0.1.1"
  license "AGPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.1/cinch_Darwin_arm64.tar.gz"
      sha256 "f47c0024673195b090180c1ee96390784920bbfa0a27e3d618a07e9886551a8a"
    else
      odie "Cinch does not publish macOS x86_64 builds. Use an Apple Silicon Mac or install the Linux/Windows build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.1/cinch_Linux_arm64.tar.gz"
      sha256 "dd27ecee40123984bf7e7e29aaeb94762c06554dd9fab50664586d3f8acc1d70"
    else
      url "https://github.com/cinchcli/cinch/releases/download/v0.1.1/cinch_Linux_x86_64.tar.gz"
      sha256 "886da71621c307c16047cd2a1a0c0d174239182205f7441111aa976ab645702c"
    end
  end

  def install
    bin.install "cinch"
  end

  test do
    system "#{bin}/cinch", "--version"
  end
end
