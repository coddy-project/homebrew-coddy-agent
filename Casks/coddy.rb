cask "coddy" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.15"
  sha256 arm:   "be0751038c12b1813c778924318a49be43af0d844604f796507fcd1885cb80a9",
         intel: "56348d5fa7f4b8a22ffaa1b8a463db28177838ad0711fec9c82cfeb742cc06fe"

  url "https://github.com/coddy-project/coddy-agent/releases/download/#{version}/coddy_#{version}_darwin_#{arch}.tar.gz"
  name "Coddy Agent"
  desc "Coding agent with a console, an editor protocol and an HTTP gateway"
  homepage "https://coddy.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  binary "coddy"
  manpage "coddy.1"
  bash_completion "coddy.bash", target: "coddy"
  zsh_completion "coddy.zsh", target: "_coddy"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{staged_path}}/coddy"], must_succeed: false
  end

  zap trash: "~/.coddy"

  caveats <<~EOS
    The zsh completion is linked into #{HOMEBREW_PREFIX}/share/zsh/site-functions.
    zsh loads it once compinit runs with that directory on fpath, and the zsh
    macOS ships runs no compinit. If Tab does not complete coddy, add to ~/.zshrc:
      fpath=(#{HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)
      autoload -Uz compinit && compinit
    and open a new terminal.

    Coddy does not need tmux, but its console runs well inside it: a session
    there outlives a closed terminal or a dropped SSH connection. To add it:
      brew install tmux
  EOS
end
