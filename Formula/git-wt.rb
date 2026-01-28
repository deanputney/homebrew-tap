# This is a template formula. PLACEHOLDER_* values are replaced by GitHub Actions.
# See .github/workflows/update-homebrew-formula.yml for the automation.
class GitWt < Formula
  desc "Enhanced workflows for Git worktrees"
  homepage "https://github.com/deanputney/git-wt"
  url "https://github.com/deanputney/git-wt/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "432d8b83e237386958835a9281ea05fb96d2e0759a557a699a0dcff63068756a"
  license "MIT"
  version "0.0.1"

  depends_on "git"

  def install
    bin.install "git-wt"
  end

  def post_install
    # Offer to set up the git alias
    ohai "Setting up git alias"
    system "git", "config", "--global", "alias.wt", "!git-wt"
  rescue
    opoo "Could not set git alias automatically"
    ohai "To use git-wt as 'git wt', run:"
    puts "  git config --global alias.wt '!git-wt'"
  end

  def caveats
    <<~EOS
      git-wt has been installed!

      The git alias 'git wt' should be configured automatically.
      If not, you can set it up manually:
        git config --global alias.wt '!git-wt'

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
