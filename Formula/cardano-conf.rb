class CardanoConf < Formula
  desc "Configuration files for Cardano core components"
  homepage "https://github.com/input-output-hk/cardano-playground"
  url "https://github.com/input-output-hk/cardano-playground/archive/f02b36feb858049ba451957c57166ce3148c4072.tar.gz"
  sha256 "cfebb475adebc278e4a21ef6ff32e6be58678c9ca7527e0d871ee3975facd8c1"
  license "Apache-2.0"
  version "11.1.3-config"

  def install
    # Make a copy of the configs so it doesn't get clobbered by `etc.install`
    cp_r "static/book.play.dev.cardano.org/environments", "environments"
    # Move the original out to etc
    etc.install "static/book.play.dev.cardano.org/environments" => "cardano"
    # An etc-only formula is seen as an empty installation, so copy the
    # configs to pkgshare. This also serves as an up-to-date pristine config snapshot
    # users can use as a reference
    pkgshare.install "environments"
  end

  def caveats
    <<~EOS
      Cardano services will use configs in #{etc}/cardano.

      Up-to-date reference copies are available in #{opt_pkgshare}/environments.
    EOS
  end

  test do
    assert_predicate etc/"cardano/mainnet/config.json", :exist?
    assert_predicate pkgshare/"environments/mainnet/config.json", :exist?
  end
end
