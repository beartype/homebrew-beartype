class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/1d/2a/0a80d07fc955fd1ebdd3ee54971432d39f06953ee6b6c307d58e0897ce09/beartype-0.16.1.tar.gz"
  sha256 "b3bfb911ed6af91aeada851a44b4d564c23662869b5391d71fe3648f2c643b6d"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.16.1"
    sha256 cellar: :any_skip_relocation, ventura:      "d57dfc80ac3de94d24395ffe3bdaa7fadf247c4a66124bcef091fb1aaeccd844"
    sha256 cellar: :any_skip_relocation, monterey:     "9e4cd131e1417effb9d666f9259cd58727989131158a5b5b5d02860720218567"
    sha256 cellar: :any_skip_relocation, big_sur:      "6e1dde153fa3ac5920c9b24fec20caff4ae526eb3a9d65355080d851a034cdba"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "787ce893d63001a9bede301ad94269fd6bc26af6770463f20d09bda7c8d3f77c"
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
