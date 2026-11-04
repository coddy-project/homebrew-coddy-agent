cask "coddy" do
  arch arm: "arm64", intel: "amd64"

  version "1.3.81"
  sha256 arm:   "f139d432da01b41f03407a2993ac8f5862fa1ab430f12f8cfd95411eb8469ae2",
         intel: "f77a938984c3c02bac8a83299dfd18faca8060dfa85f057a221e7632f4f65ee7"

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
