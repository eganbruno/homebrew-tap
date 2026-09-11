class Grit < Formula
  desc "Work across many git and dolt repositories from anywhere, by alias."
  homepage "https://github.com/eganbruno/grit"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eganbruno/grit/releases/download/v0.3.0/grit-aarch64-apple-darwin.tar.xz"
      sha256 "3a7120438fa741970065f460aa7b89b27c250a840d06760037483e23cd3e7c9d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eganbruno/grit/releases/download/v0.3.0/grit-x86_64-apple-darwin.tar.xz"
      sha256 "7f7ec254730ce488728a795299f439f3de2cc02dd78cac5d2134558a4e8e9688"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eganbruno/grit/releases/download/v0.3.0/grit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4b624cf647a8bd8b5bbe74aca8aa0f654b34164503b2ba193af73cda9152eaf0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eganbruno/grit/releases/download/v0.3.0/grit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1e89f9ea1f2879d5b20bc879922c6368d0a953772dcecb2c76d254eca09ad502"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "grit"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "grit"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "grit"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "grit"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
