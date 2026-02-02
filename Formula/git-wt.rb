# This is a template formula. PLACEHOLDER_* values are replaced by GitHub Actions.
# See .github/workflows/update-homebrew-formula.yml for the automation.
class GitWt < Formula
  desc "Enhanced workflows for Git worktrees"
  homepage "https://github.com/deanputney/git-wt"
  url "https://github.com/deanputney/git-wt/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "1437e80a2f428f4d0f730404c91e6c418d05c36be6a32bdd9ec4e8bf993a80da"
  license "MIT"
  version "0.0.2"

  depends_on "git"

  def install
    bin.install "git-wt"
  end

  def post_install
    # Configure git alias using the built-in setup command
    ohai "Configuring git alias"
    system bin/"git-wt", "setup", "--config-only"
  rescue
    opoo "Could not set git alias automatically"
    ohai "To use git-wt as 'git wt', run:"
    puts "  git-wt setup --config-only"
  end

  def caveats
    <<~EOS
      git-wt has been installed!

      The git alias 'git wt' should be configured automatically.
      If not, you can set it up with:
        git-wt setup --config-only

      Get started:
        git wt --help
        git wt clone <repository-url>

      Reorganize an existing repository with worktrees:
        git wt init
    EOS
  end

  test do
    system "#{bin}/git-wt", "--help"
  end
end
