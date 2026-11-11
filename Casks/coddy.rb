cask "coddy" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.3"
  sha256 arm:   "10b3736e3da225880183db8e78f26d8da83b31e1bfbe14c5ac1e0b7f9fc7de96",
         intel: "20ad0468aa7fd386a3837a36c32e8065bc9f37d92f4af6825181583e4827ef97"

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
