class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/b3/7c/0c6451ff5477cf6f3ac5101cafd084e43e3a29242d28f2056cad76ff03e9/beartype-0.11.0.tar.gz"
  sha256 "3854b50eaaa98bb89490be57e73c69c777a0f304574e7043ac7da98ac6a735a6"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.11.0"
    sha256 cellar: :any_skip_relocation, monterey:     "f157b9ca23959bb382e02555585b842dccd54d635130c759b04fad5e2c5e3cea"
    sha256 cellar: :any_skip_relocation, big_sur:      "94fb71fe4d9ab77627c60c682424920ba5955573bf5c5e6ae052a3decbd6b928"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e6f86201d690fed990d41a9111ba6d5bfcb0c615a68f7635c5761773fab33a1f"
  end

  depends_on "python@3.10"

  def install
    # Based on name-that-hash
    # https://github.com/Homebrew/homebrew-core/blob/9652b75b2bbaf728f70c50b09cce39520c08321d/Formula/name-that-hash.rb
    virtualenv_install_with_resources

    xy = Language::Python.major_minor_version Formula["python@3.10"].opt_bin/"python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-beartype.pth").write pth_contents
  end

  test do
    # Simple version number check
    system Formula["python@3.10"].opt_bin/"python3", "-c", <<~EOS
      import #{name}
      assert #{name}.__version__ == "#{version}"
    EOS
  end
end
