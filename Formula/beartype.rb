class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/79/cb/90bc2f441956fa6abe0ab6ec977e9a0b2f0d92ce6a40d11cccf444d99518/beartype-0.17.0.tar.gz"
  sha256 "3226fbba8c53b4e698acdb47dcaf3c0640151c4d405618c281e6631f4112947d"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.16.4"
    sha256 cellar: :any_skip_relocation, ventura:      "173eedf109ae04b93694a5c80f0706e4e4908d5b1e0806a1708ebdd6d431e718"
    sha256 cellar: :any_skip_relocation, monterey:     "987430ebb9e3f708fb1a4462fbbf132c7ddde410f05e9285e968e30f1b5a33e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2b1a5ca1ffb41198d51e3006662f18ef52ac029aa5846dd3abbae1b6c043dff3"
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
