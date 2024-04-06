class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/f2/c8/59fc7d7429b8849aaa69d25dfac94da3cc8afcba6658f64e8cc17fe023ca/beartype-0.18.2.tar.gz"
  sha256 "a6fbc0be9269889312388bfec6a9ddf41bf8fe31b68bcf9c8239db35cd38f411"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.18.0"
    sha256 cellar: :any_skip_relocation, ventura:      "eda1e84717dcb00b7f0670779af57a734ebb4c3fbe0ea2fad1f13ee44d60b2cd"
    sha256 cellar: :any_skip_relocation, monterey:     "017077af37297503cf15b4633c840be4141ec2c4f2c66a0eb2bf9e55938a519e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2b3cd8b8a5599e57d8f21189390a2e54c2ca70c51222f1ee9ddfb01230cb19ec"
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
