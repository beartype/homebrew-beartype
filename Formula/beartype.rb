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
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.17.0"
    sha256 cellar: :any_skip_relocation, ventura:      "b9a9b26893e2d146d008fcb65114d1bc4ee6dd435f1557845346b7a21762cd46"
    sha256 cellar: :any_skip_relocation, monterey:     "22f1aa2170bf14da54d92544996089dd0a720e12770cb0ef96f26f9bb8b8d712"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3d113f823025a2c675ea249f00834fd9f2bbb06399646bfce4e7330a39d527fc"
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
