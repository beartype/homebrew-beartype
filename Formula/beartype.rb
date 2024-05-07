class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/96/15/4e623478a9628ad4cee2391f19aba0b16c1dd6fedcb2a399f0928097b597/beartype-0.18.5.tar.gz"
  sha256 "264ddc2f1da9ec94ff639141fbe33d22e12a9f75aa863b83b7046ffff1381927"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.18.2"
    sha256 cellar: :any_skip_relocation, ventura:      "96c1d39169e41705a6556607cf9ec1497c5ca30e5e9e7f4bf3f7cd82d3641efc"
    sha256 cellar: :any_skip_relocation, monterey:     "3eca38f9ec49a8f21ca84ed1b20fc293aa4e2f4bbd5f87764e6c7e694a5d76a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6d7c02e09da7070bd83a2a39b26360be9b6f1dbfa37de1ddcf4aaf63e85185af"
  end

  depends_on "python@3.11"

  def install
    # Based on name-that-hash
    # https://github.com/Homebrew/homebrew-core/blob/9652b75b2bbaf728f70c50b09cce39520c08321d/Formula/name-that-hash.rb
    virtualenv_install_with_resources

    xy = Language::Python.major_minor_version Formula["python@3.11"].opt_bin/"python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-beartype.pth").write pth_contents
  end

  test do
    # Simple version number check
    system Formula["python@3.11"].opt_bin/"python3.11", "-c", <<~EOS
      import #{name}
      assert #{name}.__version__ == "#{version}"
    EOS
  end
end
