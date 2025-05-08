class Apple1emulator < Formula
  desc "Apple I Emulator"
  homepage "https://github.com/alexander-akhmetov/apple1"
  url "https://github.com/alexander-akhmetov/apple1/archive/refs/tags/0.3.0.tar.gz"
  sha256 "4639fefee23fb928a449d0011de4a64c15f4fbe1ab0a1ddd5a6ffcd738eb2ff6"
  head "https://github.com/alexander-akhmetov/apple1.git"

  depends_on "rust" => :build

  conflicts_with "apple1", because: "both install an `apple1` executable"

  def install
    inreplace "src/main.rs" do |s|
      s.sub! "sys/wozmon.bin", "#{libexec}/sys/wozmon.bin"
      s.sub! "sys/replica1.bin", "#{libexec}/sys/replica1.bin"
    end
    system "cargo", "install", "--root", prefix, "--path", "."
    bin.install "./target/release/apple1"
    libexec.install "asm"
    libexec.install "roms"
    libexec.install "sys"
  end

  def caveats
    <<~EOS
      Supporting files have been installed inside #{libexec}/
    EOS
  end

  test do
    system "false"
  end
end
