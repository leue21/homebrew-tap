class Morse < Formula
  desc "Send a notification to Telegram from the command line"
  homepage "https://github.com/leue21/morse"
  url "https://github.com/leue21/morse/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "df47346056f6db3e387698f5d1abf012da09aed1665aa0b7ae3ea5d0dd72b349"
  license "MIT"
  head "https://github.com/leue21/morse.git", branch: "main"

  depends_on "go" => :build

  def install
    # A tarball build has no git metadata, so the release is stamped in here;
    # without it `morse version` could only answer "devel".
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
  end

  def caveats
    <<~EOS
      Credentials go in ~/.config/morse/config.yaml:

        telegram:
          bot_token: "123456:ABC-DEF..."   # from @BotFather
          chat_id: 12345678                # your chat/group ID

      Or in the environment, which wins over the file:

        export MORSE_BOT_TOKEN=... MORSE_CHAT_ID=...

      Check it with: morse capabilities
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/morse version")

    # capabilities answers before there are any credentials to answer with,
    # which is what makes it usable as an install check.
    output = shell_output("#{bin}/morse capabilities --config #{testpath}/absent.yaml")
    assert_match "not configured", output
    assert_match "morse send", output

    # A send with no text and no file has nothing to deliver and says so.
    assert_match "nothing to send", shell_output("#{bin}/morse send 2>&1", 1)
  end
end
