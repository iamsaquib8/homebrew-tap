# Homebrew formula for the `domq` CLI, installed from the prebuilt binaries
# that .github/workflows/release.yml attaches to each GitHub release.
class Domq < Formula
  desc "Query HTML with CSS selectors: elements, attributes, text, Markdown or JSON"
  homepage "https://github.com/iamsaquib8/domq"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/iamsaquib8/domq/releases/download/v#{version}/domq-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "72394cf318cf2e5e2821ed70ab5feb740f931cb0799f628b352718e61d3e33ac"
    end
    on_intel do
      url "https://github.com/iamsaquib8/domq/releases/download/v#{version}/domq-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "d28fa7663c48aac5e77762c9a8ad6307a2560bedba679c4eca1767257914ec5c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/iamsaquib8/domq/releases/download/v#{version}/domq-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "78ee0ef58b8a08f62b5d7bb826c1f1ebcc727005bcab7f8be18bd03bafa42d82"
    end
    on_intel do
      url "https://github.com/iamsaquib8/domq/releases/download/v#{version}/domq-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "067af5da06916a3aad0f60cf30931eee3c1e9bc194dbbd81afa6649be9b92c04"
    end
  end

  def install
    # Each archive holds a single `domq-v<version>-<target>/` directory,
    # which Homebrew has already entered.
    bin.install "domq"
    doc.install "README.md"
  end

  test do
    assert_match "domq #{version}", shell_output("#{bin}/domq --version")

    html = "<ul><li class='x'>a</li><li>b &amp; c</li></ul>"
    assert_equal "a\nb & c\n", pipe_output("#{bin}/domq -t li", html)
    assert_equal "2\n", pipe_output("#{bin}/domq -c li", html)
    assert_equal "x\n", pipe_output("#{bin}/domq -a class li", html)
    assert_equal "- a\n- b & c\n", pipe_output("#{bin}/domq --markdown ul", html)
  end
end
