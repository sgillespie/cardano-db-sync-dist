class CardanoConf < Formula
  desc "Configuration files for Cardano core components"
  homepage "https://github.com/input-output-hk/cardano-playground"
  url "https://github.com/input-output-hk/cardano-playground/archive/e18bf6327fa9956c907739d049e9b3ec0c6a7dd6.tar.gz"
  sha256 "fc29b58e5aecf66c89baeb1da93972569282bbfab29599cd816372babf5b18c8"
  license "Apache-2.0"
  version "11.0.1-config"

  def install
    etc.install "static/book.play.dev.cardano.org/environments" => "cardano"
    # An etc-only formula is seen as an empty installation, so copy the
    # configs to pkgshare. This also serves as an up-to-date pristine config snapshot
    # users can use as a reference
    pkgshare.install "static/book.play.dev.cardano.org/environments"
  end

  def caveats
    <<~EOS
      Cardano services will use configs in #{etc}/cardano.

      Up-to-date reference copies are available in #{opt_pkgshare}/environments.
    EOS
  end

  test do
    assert_predicate "#{etc}/cardano/mainnet/config.json", :exist?
    assert_predicate "#{pkgshare}/cardano/mainnet/config.json", :exist?
    system "false"
  end
end
