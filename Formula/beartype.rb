class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/a1/b5/6588597493538be1e7526b4b47bc61e7a328171e3471cdbb526cdeaecea0/beartype-0.16.2.tar.gz"
  sha256 "47ec1c8c3be3f999f4f9f829e8913f65926aa7e85b180d9ffd305dc78d3e7d7b"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.16.2"
    sha256 cellar: :any_skip_relocation, ventura:      "0c2bf736fa9accfb20e8efe6de4fc6e990c4eec37d8791207750d383a92361bf"
    sha256 cellar: :any_skip_relocation, monterey:     "bb38df5c5efe556e1d82305d2b49d9680930ded9bdca29d7ab4e1a268ebe9fef"
    sha256 cellar: :any_skip_relocation, big_sur:      "e6a6f4f5aace310e6c149ce44a20ef24e7e329be7d2f8e67248cf39819899812"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9a4708c04a622bec606dc5c7299b4e83303837af01826d32f1d5e3a5b40d30e3"
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
