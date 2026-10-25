# Homebrew formula for the `domq` CLI, installed from the prebuilt binaries
# that .github/workflows/release.yml attaches to each GitHub release.
class Domq < Formula
  desc "Query HTML with CSS selectors: elements, attributes, text, Markdown or JSON"
  homepage "https://github.com/iamsaquib8/domq"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/iamsaquib8/domq/releases/download/v#{version}/domq-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "39ed5b8905650bc5356cbeb8e55a48e9f3a1d8ce77d142749924121b5ae5f364"
    end
    on_intel do
      url "https://github.com/iamsaquib8/domq/releases/download/v#{version}/domq-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "7c849578d7123f74c5f9f77e707e0d259b107a9825f94323baae2a5311053b72"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/iamsaquib8/domq/releases/download/v#{version}/domq-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "018de959b4f7b0f9e533f3ad128563c0ac00fa8e7d833c7a1bc3402df4d6234e"
    end
    on_intel do
      url "https://github.com/iamsaquib8/domq/releases/download/v#{version}/domq-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3a1240c18a79e978d6820a333b6a229aa93c255dca3c75d2435a17fa70eb99d9"
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
