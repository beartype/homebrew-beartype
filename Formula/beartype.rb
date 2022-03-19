class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/26/e1/8323460360d73ca09f24384483c9facbf9f586928bdd9f0e80fdcc72dace/beartype-0.10.4.tar.gz"
  sha256 "24ec69f6a7f4e6e97af403d08de270def3248518060327095d23b1c4df64bf2a"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.10.4"
    sha256 cellar: :any_skip_relocation, catalina:     "d9be1c4363ef4d45fbc2effa5fef9f25f63c09e432072684c5e7987449db7010"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "64ac0928c31f1b7b1dabd1b01f2d4aca0e074dbf74a191be7f974ac5e02b9f13"
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
