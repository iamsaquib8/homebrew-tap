# Homebrew formula for the `domtree` CLI, installed from the prebuilt binaries
# that .github/workflows/release.yml attaches to each GitHub release.
class Domtree < Formula
  desc "Query HTML with CSS selectors: elements, attributes, text, Markdown or JSON"
  homepage "https://github.com/iamsaquib8/dom-tree-rs"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/iamsaquib8/dom-tree-rs/releases/download/v#{version}/domtree-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "b0dfdf28f574e820d83f30426c8559705f389c0be4c60d6b13fe7dd67195ec82"
    end
    on_intel do
      url "https://github.com/iamsaquib8/dom-tree-rs/releases/download/v#{version}/domtree-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "2a020f49d1281063d63a54b96246e3ef76be0ce640f868374e35f4e15b907822"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/iamsaquib8/dom-tree-rs/releases/download/v#{version}/domtree-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6c4bc3baecd45525d941228ab121d3563f96387002934c3bd3f58408c073e831"
    end
    on_intel do
      url "https://github.com/iamsaquib8/dom-tree-rs/releases/download/v#{version}/domtree-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0d9f4c0fe422726f5ac86d5ca557ddaf04325d47e87da3cc7468d817f04ab1c9"
    end
  end

  def install
    # Each archive holds a single `domtree-v<version>-<target>/` directory,
    # which Homebrew has already entered.
    bin.install "domtree"
    doc.install "README.md"
  end

  test do
    assert_match "domtree #{version}", shell_output("#{bin}/domtree --version")

    html = "<ul><li class='x'>a</li><li>b &amp; c</li></ul>"
    assert_equal "a\nb & c\n", pipe_output("#{bin}/domtree -t li", html)
    assert_equal "2\n", pipe_output("#{bin}/domtree -c li", html)
    assert_equal "x\n", pipe_output("#{bin}/domtree -a class li", html)
    assert_equal "- a\n- b & c\n", pipe_output("#{bin}/domtree --markdown ul", html)
  end
end
