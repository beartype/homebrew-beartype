class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/c3/ea/e9d11faffebeed65c46d8b06b53d13d004fabd036cbe919fbd8644913f33/beartype-0.17.1.tar.gz"
  sha256 "001df1ce51c76f0a21c2183215b26254b667fd8b688a6cbe8f013907cdaaf9b3"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.17.1"
    sha256 cellar: :any_skip_relocation, ventura:      "be135084817d7a43b39edbea8631e069d7cf0a31bdb9c169f4a64a2d96a0522b"
    sha256 cellar: :any_skip_relocation, monterey:     "c231347962657fc3d3378b535e08a86a9fa79133c4fb21c3f0834d111f823b11"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "079424be15026a8c605a8737a0632b6f6c705470c425d62068e938ea8d9e68e9"
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
