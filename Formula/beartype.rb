class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/95/78/bf7a20712dbf3a18e37f9ae1c2a1e04169c43b4628871f40f1db5f29c257/beartype-0.12.0.tar.gz"
  sha256 "3b7545b3f333a6b07042b68b102141554c9add2e979dab7b0f8ed6378f7af7d7"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.12.0"
    sha256 cellar: :any_skip_relocation, monterey:     "c1ecf9414a1e0bfab118b910a1fc11fc3615d1cbaf32c09a57ac02d80bc93982"
    sha256 cellar: :any_skip_relocation, big_sur:      "7836cae13da0a943144386d4f24e1d3da242d604e4446b9a511df04e3bd27b25"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "41973bd6e9ae94fd06c2acbe80b589805b12ce4cfdc692f65878b56f60381e2c"
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
