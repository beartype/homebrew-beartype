class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/89/3b/9ecfc75d1f8bb75cbdc87fcb3df7c6ec4bc8f7481cb7102859ade1736c9d/beartype-0.14.1.tar.gz"
  sha256 "23df4715d19cebb2ce60e53c3cf44cd925843f00c71938222d777ea6332de3cb"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.14.0"
    sha256 cellar: :any_skip_relocation, monterey:     "7aa2db34d1558a6a0cb1c683840be8b0af61930bd8bb5bafea1c2a6b3c5434f0"
    sha256 cellar: :any_skip_relocation, big_sur:      "218da46a16dc2adc3f91969b59704915fc9bb385daeafa5f212e4e75bc51aa65"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1b6885a9c1358b38b718d1c2a889109fc2d807bbe2ac9661c4515fec21656d58"
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
