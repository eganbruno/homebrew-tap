class Grit < Formula
  desc "Work across many git and dolt repositories from anywhere, by alias."
  homepage "https://github.com/eganbruno/grit"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/eganbruno/grit/releases/download/v0.2.0/grit-aarch64-apple-darwin.tar.xz"
      sha256 "1339409b0faa2446270da4d704efee6d3c19d2d1e54d41c13fa2eeeb27e92dea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eganbruno/grit/releases/download/v0.2.0/grit-x86_64-apple-darwin.tar.xz"
      sha256 "ebf50e573fb24d9c5fa1ca675c1b011df5acb0b3cb0830c7b1492c78dacbcbe0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/eganbruno/grit/releases/download/v0.2.0/grit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d54888823eaaee842e25c6095b57d3e5e7b159423c93a526036d2866780f798"
    end
    if Hardware::CPU.intel?
      url "https://github.com/eganbruno/grit/releases/download/v0.2.0/grit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ec7b38fd52a55f3c92e0db7a830a65ade57b3d1d6178c48dc50faa51cea83f1a"
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
