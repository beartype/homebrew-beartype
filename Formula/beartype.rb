class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/82/e2/bb1da3f5bfb87357ca91dddf03d30a9ca414b9daf244fa0bba40a666c5a1/beartype-0.16.0.tar.gz"
  sha256 "231379a056da2fc1811a2e1324d5c3d0fa2082e305bfa15cb3acb9b7ce9df516"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.15.0"
    sha256 cellar: :any_skip_relocation, ventura:      "8a910af41b92bfbab7f2da038b9b694dbdc7715163c69e2942e2ddafeec71304"
    sha256 cellar: :any_skip_relocation, monterey:     "94c8b4c395db4c33f31ac01485e4a9815ecd35c097dd8c8e6f988ef552e0d5bd"
    sha256 cellar: :any_skip_relocation, big_sur:      "2017002c5170eed2d7d61774e842aa591a0f9bfcd04bc9928a037037e5a4584e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d5cc44b36a8cdad1bc2696f7f897129dca7308a85471b372b5615272a71713c4"
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
