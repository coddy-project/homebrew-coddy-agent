cask "coddy" do
  arch arm: "arm64", intel: "amd64"

  version "1.3.16"
  sha256 arm:   "a9b57d416682bc4d71232be8ed8fa2b73f413c40a7f7b94087b81f36ee98ff4e",
         intel: "141d45c4fcbce746e0ce43148924472974ae61676e63d548e705c1e9e1a2ac5b"

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
    Coddy does not need tmux, but its console runs well inside it: a session
    there outlives a closed terminal or a dropped SSH connection. To add it:
      brew install tmux
  EOS
end
