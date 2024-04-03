class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/c5/dc/f0fd83bda2b528d140a2b2059a989f9b30f20a99c97d8df4da9048e67917/beartype-0.18.0.tar.gz"
  sha256 "aa254f7cf87eea6cdd329f488b5d8282f6f30befe496fbbcd844d92ede6e6f23"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.17.2"
    sha256 cellar: :any_skip_relocation, ventura:      "0cd59cda1dc846a57d8e69b493b06a88bd13cee5a8f58471425ce737e578ab73"
    sha256 cellar: :any_skip_relocation, monterey:     "898c9e1c0a7dd664866ce1812227d41fb3dfb2e8818b51f187dda4866c6dcb4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a6c72fdd2c4aa88dbc768d64c084719cb15d8ce812f278988557e251a4e1e532"
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
